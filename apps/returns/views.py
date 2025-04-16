
from django.shortcuts import get_object_or_404
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from .models import Devolucion
from weasyprint import HTML
from django.template.loader import get_template
from django.shortcuts import redirect
from django.db import transaction
from django.contrib import messages
from .models import Devolucion, DetalleDevolucion
from apps.ventas.models import Factura
from apps.productos.models import Producto
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ValidationError
from datetime import datetime, timedelta


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
    low_stock_products = Producto.objects.filter(stock__lte=25)

    context = {
        "empleado": employe,
        "es_almacen": "Almacen" in user_groups,
        "es_vendedor": "Vendedor" in user_groups,
        "facturas": [],
        'low_stock_products': low_stock_products,
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
from django.http import JsonResponse
from django.db import transaction
from datetime import datetime, timedelta
from django.core.exceptions import ValidationError

from django.http import JsonResponse
from django.db import transaction
from datetime import datetime, timedelta
from django.core.exceptions import ValidationError
from django.core.exceptions import ObjectDoesNotExist

@seller_required
@login_required
def process_return_view(request):
    if request.method == 'POST':
        try:
            with transaction.atomic():
                factura_id = request.POST.get('factura_id')
                metodo_reembolso = request.POST.get('metodo_reembolso')
                comentarios = request.POST.get('comentarios', '')

                # Validar campos requeridos
                if not factura_id:
                    raise ValueError("Ingresa el número de factura.")
                if not metodo_reembolso or metodo_reembolso == 'seleccionar':
                    raise ValueError("Selecciona un método de reembolso válido.")

                # Obtener la factura
                try:
                    factura = Factura.objects.get(id=factura_id)
                except ObjectDoesNotExist:
                    raise ValueError("La factura no existe. Verifica el número ingresado.")

                # Verificar plazo de 30 días
                fecha_limite = factura.fecha_emision + timedelta(days=30)
                fecha_actual = datetime.now().date()
                if fecha_actual > fecha_limite.date():
                    raise ValidationError("No se puede procesar la devolución porque han pasado más de 30 días desde la compra.")

                # Validar campos numéricos
                try:
                    subtotal = float(request.POST.get('subtotal', 0))
                    impuesto = float(request.POST.get('impuesto', 0))
                    descuento = float(request.POST.get('descuento', 0))
                    total_devolver = float(request.POST.get('total_devolver', 0))
                except (TypeError, ValueError):
                    raise ValueError("Los valores de subtotal, impuesto, descuento o total a devolver deben ser números.")

                # Crear devolución
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

                # Procesar productos devueltos
                productos_devueltos = request.POST.getlist('productos_devueltos')
                if not productos_devueltos:
                    raise ValueError("Selecciona al menos un producto para devolver.")

                for producto_nombre in productos_devueltos:
                    try:
                        cantidad = int(request.POST.get(f'cantidad_{producto_nombre}', 0))
                    except (TypeError, ValueError):
                        raise ValueError(f"La cantidad para el producto {producto_nombre} debe ser un número entero.")

                    motivo = request.POST.get(f'motivo_{producto_nombre}', 'OTRO').upper()

                    try:
                        producto = Producto.objects.get(nombre=producto_nombre)
                    except ObjectDoesNotExist:
                        raise ValueError(f"El producto {producto_nombre} no existe.")

                    if cantidad <= 0:
                        raise ValueError(f"La cantidad para el producto {producto_nombre} debe ser mayor a cero.")

                    DetalleDevolucion.objects.create(
                        devolucion=devolucion,
                        producto=producto,
                        cantidad=cantidad,
                        precio_unitario=float(producto.precio),
                        motivo=motivo
                    )

                return JsonResponse({
                    'success': True,
                    'message': 'La devolución se procesó correctamente.',
                    'devolucion_id': devolucion.id
                })

        except ValidationError as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            }, status=400)

        except ValueError as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            }, status=400)

        except Exception as e:
            print(f"Error inesperado: {str(e)}")  # Para depuración en el servidor
            return JsonResponse({
                'success': False,
                'message': 'Ocurrió un problema al procesar la devolución. Intenta de nuevo.'
            }, status=500)

    return JsonResponse({
        'success': False,
        'message': 'Método no permitido.'
    }, status=405)
@login_required
def download_return_receipt_pdf(request, devolucion_id):
    # Obtiene la devolución asociada con el ID
    devolucion = get_object_or_404(Devolucion, id=devolucion_id)
    detalles = devolucion.detalles.all()
    
    # Prepare detalles with calculated subtotals
    detalles_with_subtotal = [
        {
            'detalle': detalle,
            'subtotal': detalle.cantidad * detalle.precio_unitario
        }
        for detalle in detalles
    ]
    
    context = {
        'devolucion': devolucion,
        'detalles': detalles_with_subtotal,
        'total_subtotal': sum(d['subtotal'] for d in detalles_with_subtotal),
    }
    
    pdf_content = render_to_pdf("returns/return_receipt.html", context)
    
    if pdf_content:
        response = HttpResponse(pdf_content, content_type='application/pdf')
        filename = f"Comprobante_Devolucion_{devolucion.id}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{filename}"'
        return response
    else:
        return HttpResponse("No se pudo generar el PDF", status=500)
def render_to_pdf(template_src, context_dict=None):
    """
    Renderiza una plantilla HTML a PDF usando WeasyPrint.
    
    Args:
        template_src (str): Ruta de la plantilla.
        context_dict (dict): Contexto para renderizar la plantilla.
    
    Returns:
        bytes: Contenido del PDF, o None si falla.
    """
    if context_dict is None:
        context_dict = {}
    
    try:
        # Carga y renderiza la plantilla
        template = get_template(template_src)
        html_string = template.render(context_dict)
        
        # Genera el PDF
        html = HTML(string=html_string)
        pdf_content = html.write_pdf()
        
        return pdf_content
    except Exception as e:
        # Log the error for debugging (optional)
        print(f"Error generando PDF: {e}")
        return None