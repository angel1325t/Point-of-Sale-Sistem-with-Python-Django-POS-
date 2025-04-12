from django.shortcuts import redirect
from django.db import transaction
from django.contrib import messages
from .models import Devolucion, DetalleDevolucion
from apps.ventas.models import Factura
from apps.productos.models import Producto
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ValidationError


def user_is_not_wareHouse(user):
    # Verifica si el usuario NO pertenece al grupo 'Almacen'
    return "Almacen" not in user.groups.values_list("name", flat=True)

def seller_required(view_func):
    """
    Decorador que permite acceso a todos los usuarios excepto los del grupo 'Almacen'.
    Si pertenecen a 'Almacen', se devuelve un error 403.
    """
    from django.contrib.auth.decorators import user_passes_test
    return user_passes_test(user_is_not_wareHouse, login_url=None)(view_func)

@seller_required
@login_required
def search_returns_view(request):
    employe = request.user
    user_groups = request.user.groups.values_list("name", flat=True)

    context = {
        "empleado": employe,
        "es_almacen": "Almacen" in user_groups,
        "es_vendedor": "Vendedor" in user_groups,
        "facturas": [],  # Por si acaso se quiere usar sin resultados
    }

    if request.method == 'POST':
        # Buscar facturas
        invoice_number = request.POST.get('numero_factura', '').strip()
        sale_date = request.POST.get('fecha_venta', '').strip()

        invoices = Factura.objects.all()
        if invoice_number:
            invoices = invoices.filter(numero_factura__icontains=invoice_number)

        results = []
        for factura in invoices:
            vendedor = factura.venta.empleado.username if hasattr(factura.venta, 'empleado') and factura.venta.empleado else 'Sin vendedor'
            detalles = factura.venta.detalles.all()
            productos = [
                {
                    'nombre': detalle.producto.nombre,
                    'cantidad': detalle.cantidad,
                    'precio_unitario': detalle.precio_unitario,
                    'descuento': detalle.descuento,
                    'cantidad_descuento': detalle.cantidad_descuento,
                    'subtotal': detalle.subtotal,
                    'image': detalle.producto.image.url,
                }
                for detalle in detalles
            ]

            results.append({
                'id': factura.id,
                'numero_factura': factura.numero_factura,
                'fecha_venta': factura.fecha_emision.strftime('%d/%m/%Y'),
                'vendedor': vendedor,
                'productos': productos,
            })

        context['facturas'] = results

    return render(request, 'returns/returns.html', context)
@seller_required
@login_required
def process_return_view(request):
    if request.method == 'POST':
        try:
            with transaction.atomic():
                print("Iniciando procesamiento de devolución...")

                factura_id = request.POST.get('factura_id')
                metodo_reembolso = request.POST.get('metodo_reembolso')
                comentarios = request.POST.get('comentarios', '')

                print(f"Factura ID: {factura_id}")
                print(f"Método de reembolso: {metodo_reembolso}")
                print(f"Comentarios: {comentarios}")

                if not factura_id or not metodo_reembolso or metodo_reembolso == 'seleccionar':
                    raise ValueError("Faltan datos requeridos o el método de reembolso no es válido.")

                factura = Factura.objects.get(id=factura_id)
                print(f"Factura encontrada: {factura}")

                subtotal = float(request.POST.get('subtotal', 0))
                impuesto = float(request.POST.get('impuesto', 0))
                descuento = float(request.POST.get('descuento', 0))
                total_devolver = float(request.POST.get('total_devolver', 0))

                print(f"Subtotal: {subtotal}, Impuesto: {impuesto}, Descuento: {descuento}, Total a devolver: {total_devolver}")

                devolucion = Devolucion.objects.create(
                    factura=factura,
                    motivo_general='OTRO',
                    metodo_reembolso=metodo_reembolso.upper(),
                    subtotal=subtotal,
                    impuesto=impuesto,
                    descuento=descuento,
                    total_devolver=total_devolver,
                    comentarios=comentarios
                )
                print(f"Devolución creada: {devolucion}")

                productos_devueltos = request.POST.getlist('productos_devueltos')
                print(f"Productos devueltos: {productos_devueltos}")

                for producto_nombre in productos_devueltos:
                    cantidad = int(request.POST.get(f'cantidad_{producto_nombre}', 0))
                    motivo = request.POST.get(f'motivo_{producto_nombre}', 'OTRO').upper()
                    producto = Producto.objects.get(nombre=producto_nombre)
                    precio_unitario = float(producto.precio)

                    print(f"Procesando producto: {producto_nombre}, Cantidad: {cantidad}, Motivo: {motivo}, Precio unitario: {precio_unitario}")

                    if cantidad > 0:
                        detalle = DetalleDevolucion.objects.create(
                            devolucion=devolucion,
                            producto=producto,
                            cantidad=cantidad,
                            precio_unitario=precio_unitario,
                            motivo=motivo
                        )
                        print(f"DetalleDevolucion creado: {detalle}")

                messages.success(request, "Devolución procesada exitosamente.")
                print("Devolución procesada correctamente.")
                return redirect('returns')

        except ValidationError as e:
            print(f"ValidationError: {str(e)}")
            messages.error(request, str(e))
            return redirect('returns')
        except Exception as e:
            print(f"Excepción: {str(e)}")
            messages.error(request, f"Error al procesar la devolución: {str(e)}")
            return redirect('returns')

    print("Método no permitido: solo se acepta POST.")
    return redirect('returns')
