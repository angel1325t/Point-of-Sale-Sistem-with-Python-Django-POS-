# views.py
from django.shortcuts import render
from django.http import JsonResponse
from apps.ventas.models import Factura
from django.views.decorators.http import require_GET
from django.contrib.auth.decorators import login_required
from datetime import datetime

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
def returns_view(request):
    employe = request.user
    user_groups = request.user.groups.values_list("name", flat=True)
    context = {
        "empleado": employe,
        "es_almacen": "Almacen" in user_groups,
        "es_vendedor": "Vendedor" in user_groups,
    }
    return render(request, 'returns/returns.html', context)
@seller_required
@login_required
def find_invoice(request):
    if request.method == 'POST':
        user_groups = request.user.groups.values_list("name", flat=True)
        employe = request.user
        print(">>> Iniciando búsqueda de factura...")

        invoice_number = request.POST.get('numero_factura', '').strip()
        sale_date = request.POST.get('fecha_venta', '').strip()

        print(f">>> Número de factura recibido: '{invoice_number}'")
        print(f">>> Fecha de venta recibida: '{sale_date}'")

        invoices = Factura.objects.all()
        print(f">>> Total de facturas inicialmente: {invoices.count()}")

        if invoice_number:
            invoices = invoices.filter(numero_factura__icontains=invoice_number)
            print(f">>> Facturas después de filtrar por número: {invoices.count()}")

        results = []
        for factura in invoices:
            vendedor = factura.venta.empleado.username if hasattr(factura.venta, 'empleado') and factura.venta.empleado else 'Sin vendedor'
            print(f">>> Procesando factura ID {factura.id} - Vendedor: {vendedor}")

            # Obtener los detalles de la venta (productos)
            detalles = factura.venta.detalles.all()  # Usamos la relación 'detalles' de Venta
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

        print(f">>> Total de facturas encontradas: {len(results)}")
        context = {
            'facturas': results,
            'empleado': employe,
            "es_almacen": "Almacen" in user_groups,
            "es_vendedor": "Vendedor" in user_groups,
        }

        return render(request, 'returns/returns.html', context)

    return render(request, 'returns/returns.html')  # GET request