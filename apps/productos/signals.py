import os
from django.dispatch import receiver
from django.db.models.signals import post_delete, pre_save, post_save
from .models import MovimientoProducto, Producto
from apps.ventas.models import DetalleVenta

# Eliminar archivos asociados al producto (QR e imagen)
@receiver(post_delete, sender=Producto)
def eliminar_archivos_producto(sender, instance, **kwargs):
    if instance.codigo_qr:
        qr_path = instance.codigo_qr.path
        if os.path.isfile(qr_path):
            os.remove(qr_path)

    if instance.image and instance.image.name != 'productos_img/no_image.jpg':
        image_path = instance.image.path
        if os.path.isfile(image_path):
            os.remove(image_path)

# Guardar estado anterior antes de actualizar el producto
@receiver(pre_save, sender=Producto)
def guardar_estado_anterior(sender, instance, **kwargs):
    if instance.pk:
        try:
            producto_actual = Producto.objects.get(pk=instance.pk)
            instance._stock_anterior = producto_actual.stock
            instance._estado_anterior = producto_actual.__dict__.copy()
        except Producto.DoesNotExist:
            instance._stock_anterior = 0
            instance._estado_anterior = {}
    else:
        instance._stock_anterior = 0
        instance._estado_anterior = {}

# Registrar movimientos automáticos para creación o actualización del producto
@receiver(post_save, sender=Producto)
def registrar_movimiento_automatico(sender, instance, created, **kwargs):
    if hasattr(instance, '_from_venta'):  # Evitar movimientos duplicados desde ventas
        del instance._from_venta
        return

    stock_antes = getattr(instance, '_stock_anterior', 0)
    stock_despues = instance.stock
    estado_anterior = getattr(instance, '_estado_anterior', {})

    if created:
        MovimientoProducto.objects.create(
            producto=instance,
            tipo_movimiento='CREACION',
            cantidad=stock_despues,
            descripcion='Producto creado',
            stock_antes=0,
            stock_despues=stock_despues
        )
        instance._just_created = True
        return

    if hasattr(instance, '_just_created'):
        del instance._just_created
        return

    stock_changed = stock_antes != stock_despues

    other_fields_changed = False
    current_state = instance.__dict__.copy()
    campos_a_ignorar = ['stock', '_state', '_stock_anterior', '_estado_anterior', '_just_created', 'updated_at']
    for key, value in estado_anterior.items():
        if key not in campos_a_ignorar:
            if current_state.get(key) != value:
                other_fields_changed = True
                break

    if stock_changed and stock_despues > stock_antes and not other_fields_changed:
        cantidad = stock_despues - stock_antes
        MovimientoProducto.objects.create(
            producto=instance,
            tipo_movimiento='ENTRADA',
            cantidad=cantidad,
            descripcion='Ingreso de stock',
            stock_antes=stock_antes,
            stock_despues=stock_despues
        )
    elif stock_changed and stock_despues < stock_antes and not other_fields_changed:
        cantidad = stock_antes - stock_despues
        MovimientoProducto.objects.create(
            producto=instance,
            tipo_movimiento='ACTUALIZACION',  # O 'SALIDA' o 'AJUSTE' según prefieras
            cantidad=cantidad,
            descripcion='Disminución stock',
            stock_antes=stock_antes,
            stock_despues=stock_despues
        )
    elif other_fields_changed and not stock_changed:
        MovimientoProducto.objects.create(
            producto=instance,
            tipo_movimiento='ACTUALIZACION',
            cantidad=0,
            descripcion='Actualización datos',
            stock_antes=stock_antes,
            stock_despues=stock_despues
        )
    elif other_fields_changed and stock_changed:
        cantidad = abs(stock_despues - stock_antes)
        MovimientoProducto.objects.create(
            producto=instance,
            tipo_movimiento='ACTUALIZACION',
            cantidad=cantidad,
            descripcion='Actualización y stock',
            stock_antes=stock_antes,
            stock_despues=stock_despues
        )

@receiver(post_save, sender=DetalleVenta)
def registrar_salida_producto(sender, instance, created, **kwargs):
    if created:
        producto = instance.producto
        cantidad_vendida = instance.cantidad
        stock_antes = producto.stock
        stock_despues = stock_antes - cantidad_vendida

        if stock_despues < 0:
            stock_despues = 0

        producto._from_venta = True
        producto.stock = stock_despues
        producto.save()

        MovimientoProducto.objects.create(
            producto=producto,
            tipo_movimiento='SALIDA',
            cantidad=cantidad_vendida,
            stock_antes=stock_antes,
            stock_despues=stock_despues,
            descripcion='Venta realizada'
        )