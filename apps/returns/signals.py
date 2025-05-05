from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import DetalleDevolucion

@receiver(post_save, sender=DetalleDevolucion)
def replenish_stock(sender, instance, created, **kwargs):
    """
    Repone el stock del producto cuando se crea un nuevo DetalleDevolucion.
    """
    if created and not instance.inventario_repuesto:  # Solo si es nuevo y no se ha repuesto
        product = instance.producto
        if product:  # Verifica que el producto no sea None
            product.stock += instance.cantidad
            product.save()
            instance.inventario_repuesto = True  # Marca que el inventario fue repuesto
            instance.save()
            print(f"Stock actualizado para {product.nombre}: {product.stock}")