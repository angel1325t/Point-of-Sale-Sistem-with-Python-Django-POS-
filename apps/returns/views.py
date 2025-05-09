from django.shortcuts import get_object_or_404
from weasyprint import HTML
from django.template.loader import get_template
from django.db import transaction
from .models import Devolucion, DetalleDevolucion
from apps.ventas.models import Factura
from apps.productos.models import Producto
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.core.exceptions import ValidationError
from datetime import datetime, timedelta
from django.http import JsonResponse
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Count, Sum
from django.utils import timezone
from dateutil.relativedelta import relativedelta
from django.http import HttpResponse
from django.template import loader
from io import BytesIO



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
    low_stock_products = Producto.objects.filter(stock__lte=25, activo=True).order_by('-created_at')
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


@seller_required
@login_required
def process_return_view(request):
    if request.method == 'POST':
        try:
            with transaction.atomic():
                factura_id = request.POST.get('factura_id')
                metodo_reembolso = request.POST.get('metodo_reembolso')
                motivo_general = request.POST.get('motivo')
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
                    motivo_general= motivo_general,
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
    

from django.http import JsonResponse
from django.utils import timezone
from datetime import datetime, timedelta
from django.db.models import Sum
from .models import Devolucion, DetalleDevolucion  # Ajusta según tus modelos

def return_statistics(request):
    filter_type = request.GET.get('filtro', 'mensual')
    now = timezone.now()

    if filter_type == 'diario':
        start_date = datetime(now.year, now.month, now.day)
        end_date = start_date + timedelta(days=1)
    elif filter_type == 'semanal':
        start_date = now - timedelta(days=now.weekday())
        start_date = datetime(start_date.year, start_date.month, start_date.day)
        end_date = start_date + timedelta(days=7)
    else:  # mensual
        start_date = datetime(now.year, now.month, 1)
        if now.month == 12:
            end_date = datetime(now.year + 1, 1, 1)
        else:
            end_date = datetime(now.year, now.month + 1, 1)

    devoluciones = Devolucion.objects.filter(fecha_devolucion__gte=start_date, fecha_devolucion__lt=end_date)

    total_devoluciones = devoluciones.count()
    total_devuelto = sum(d.total_devolver for d in devoluciones)


    detalle_devoluciones = DetalleDevolucion.objects.filter(devolucion__in=devoluciones)
    top_product = detalle_devoluciones.values('producto__nombre').annotate(
        total_devuelto=Sum('cantidad')
    ).order_by('-total_devuelto').first()

    return JsonResponse({
        'total_devoluciones': total_devoluciones,
        'total_devuelto': float(total_devuelto),
        'producto_mas_devuelto': top_product['producto__nombre'] if top_product else '',
    })


def returns_by_period(request):
    # Get the filter from the request, default to 'monthly'
    period_filter = request.GET.get('filtro', 'mensual')
    print("Received filter:", period_filter)
    
    now = timezone.now()

    if period_filter == 'diario':
        start_date = datetime(now.year, now.month, now.day, 0, 0, 0)
        end_date = start_date + timedelta(days=1)

    elif period_filter == 'semanal':
        start_date = now - timedelta(days=now.weekday())  # Monday
        start_date = datetime(start_date.year, start_date.month, start_date.day, 0, 0, 0)
        end_date = start_date + timedelta(days=7)  # Next Monday

    else:  # mensual
        start_date = datetime(now.year, now.month, 1, 0, 0, 0)
        if now.month == 12:
            end_date = datetime(now.year + 1, 1, 1, 0, 0, 0)
        else:
            end_date = datetime(now.year, now.month + 1, 1, 0, 0, 0)

    print("Start date:", start_date, "End date:", end_date)

    # Query returns within the range
    returns = (
        Devolucion.objects
        .filter(fecha_devolucion__gte=start_date, fecha_devolucion__lt=end_date)
        .extra(select={'date': "DATE(fecha_devolucion)"})
        .values('date')
        .annotate(total=Count('id'))
        .order_by('date')
    )
    
    print("Returns found:", list(returns))

    # Build the response only with dates that have returns
    labels = []
    data = []
    for r in returns:
        date_str = r['date'].strftime('%Y-%m-%d')
        labels.append(date_str)
        data.append(r['total'])
        print(f"Date: {date_str}, Total: {r['total']}")
    
    # Return data as JSON
    response = {
        'labels': labels,
        'data': data,
    }
    print("JSON Response:", response)
    
    return JsonResponse(response)

def most_returned_products(request):
    period_filter = request.GET.get('filtro', 'mensual')
    now = timezone.now()

    if period_filter == 'diario':
        start_date = datetime(now.year, now.month, now.day, 0, 0, 0)
        end_date = start_date + timedelta(days=1)

    elif period_filter == 'semanal':
        start_date = now - timedelta(days=now.weekday())  # Monday
        start_date = datetime(start_date.year, start_date.month, start_date.day, 0, 0, 0)
        end_date = start_date + timedelta(days=7)

    else:  # mensual
        start_date = datetime(now.year, now.month, 1, 0, 0, 0)
        if now.month == 12:
            end_date = datetime(now.year + 1, 1, 1, 0, 0, 0)
        else:
            end_date = datetime(now.year, now.month + 1, 1, 0, 0, 0)

    print("Start date:", start_date, "End date:", end_date)

    products = (
        DetalleDevolucion.objects
        .filter(devolucion__fecha_devolucion__gte=start_date,
                devolucion__fecha_devolucion__lt=end_date)
        .values('producto__nombre')
        .annotate(total=Sum('cantidad'))
        .order_by('-total')[:5]
    )

    data = {
        'labels': [p['producto__nombre'] for p in products],
        'data': [p['total'] for p in products],
    }

    return JsonResponse(data)

def return_reasons_data(request):
    period_filter = request.GET.get('filtro', 'mensual')
    print(f"Received filter: {period_filter}")

    now = timezone.now()

    if period_filter == 'diario':
        start_date = datetime(now.year, now.month, now.day, 0, 0, 0)
        end_date = start_date + timedelta(days=1)

    elif period_filter == 'semanal':
        start_date = now - timedelta(days=now.weekday())  # Monday
        start_date = datetime(start_date.year, start_date.month, start_date.day, 0, 0, 0)
        end_date = start_date + timedelta(days=7)

    else:  # mensual
        start_date = datetime(now.year, now.month, 1, 0, 0, 0)
        if now.month == 12:
            end_date = datetime(now.year + 1, 1, 1, 0, 0, 0)
        else:
            end_date = datetime(now.year, now.month + 1, 1, 0, 0, 0)

    print(f"Calculated start date: {start_date}, end date: {end_date}")

    reasons = (
        Devolucion.objects
        .filter(fecha_devolucion__gte=start_date, fecha_devolucion__lt=end_date)
        .values('motivo_general')
        .annotate(total=Count('id'))
        .order_by('-total')
    )
    
    print(f"Reasons retrieved: {list(reasons)}")

    data = {
        'labels': [r['motivo_general'] for r in reasons],
        'data': [r['total'] for r in reasons],
    }
    
    print(f"Data prepared for JSON: {data}")

    return JsonResponse(data)

def return_pdf(request):
    print("Iniciando generación de resumen de devoluciones...")

    # Establecer fecha de inicio (primer día del mes actual) y fecha de fin (último día del mes actual)
    today = timezone.now()
    fecha_inicio = today.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
    fecha_fin = (fecha_inicio + relativedelta(months=1)) - timedelta(seconds=1)

    print(f"Fecha de inicio: {fecha_inicio}")
    print(f"Fecha de fin: {fecha_fin}")

    # Filtrar devoluciones desde el inicio hasta el fin del mes actual
    resumen = (
        Devolucion.objects
        .filter(fecha_devolucion__isnull=False)
        .filter(fecha_devolucion__gte=fecha_inicio)
        .filter(fecha_devolucion__lte=fecha_fin)
        .values('fecha_devolucion')
        .annotate(
            total_devoluciones=Count('id'),
            total_reembolsado=Sum('total_devolver'),
            total_productos=Sum('detalles__cantidad')
        )
        .order_by('fecha_devolucion')
    )

    print("Resumen generado:")
    for r in resumen:
        print(r)

    # Calcular el producto más devuelto
    producto_mas_devuelto = (
        DetalleDevolucion.objects
        .filter(devolucion__fecha_devolucion__gte=fecha_inicio)
        .filter(devolucion__fecha_devolucion__lte=fecha_fin)
        .values('producto__nombre')  # Asumiendo que el modelo Producto tiene un campo 'nombre'
        .annotate(total_cantidad=Sum('cantidad'))
        .order_by('-total_cantidad')
        .first()
    )

    print("Producto más devuelto:")
    print(producto_mas_devuelto)

    # Calcular el total de dinero devuelto
    total_reembolsado = (
        Devolucion.objects
        .filter(fecha_devolucion__gte=fecha_inicio)
        .filter(fecha_devolucion__lte=fecha_fin)
        .aggregate(total=Sum('total_devolver'))['total'] or 0
    )

    print(f"Total reembolsado: {total_reembolsado}")

    # Calcular el motivo más común de devolución
    motivo_mas_comun = (
        DetalleDevolucion.objects
        .filter(devolucion__fecha_devolucion__gte=fecha_inicio)
        .filter(devolucion__fecha_devolucion__lte=fecha_fin)
        .values('motivo')
        .annotate(total=Count('id'))
        .order_by('-total')
        .first()
    )

    print("Motivo más común:")
    print(motivo_mas_comun)

    # Preparar el contexto
    context = {
        'resumen': resumen,
        'producto_mas_devuelto': producto_mas_devuelto,
        'total_reembolsado': total_reembolsado,
        'motivo_mas_comun': motivo_mas_comun,
    }

    print("Contexto preparado:")
    print(context)

    # Cargar plantilla
    template = loader.get_template('returns/return_reports.html')
    html_string = template.render(context, request)

    print("HTML renderizado (fragmento):")
    print(html_string[:500])

    # Generar PDF
    pdf_file = BytesIO()
    HTML(string=html_string, base_url=request.build_absolute_uri()).write_pdf(pdf_file)
    pdf_file.seek(0)

    print("PDF generado exitosamente.")

    # Enviar PDF como respuesta
    response = HttpResponse(pdf_file.read(), content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="reporte_devoluciones.pdf"'
    print("PDF enviado como respuesta.")
    return response