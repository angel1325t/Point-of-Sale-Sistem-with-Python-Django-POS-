from django.http import HttpResponse
from django.template.loader import get_template
from datetime import datetime
from weasyprint import HTML
from django.utils import timezone
from django.contrib.auth.decorators import login_required
import stripe
from django.conf import settings
from decimal import Decimal, ROUND_HALF_UP
from django.shortcuts import render
import json
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from django.utils.timezone import now, timedelta
from .models import DetalleVenta, Venta, Transferencia, Factura
from ..productos.models import Producto
stripe.api_key = settings.STRIPE_SECRET_KEY
from io import BytesIO
from dateutil.relativedelta import relativedelta
from django.db.models import Sum, F, DecimalField
from django.db.models.expressions import ExpressionWrapper
from django.template.loader import render_to_string


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

def user_is_gerente_or_manager(user):
    # Verifica si el usuario es superusuario o pertenece al grupo 'Gerente'
    return user.is_superuser or "Gerente" in user.groups.values_list("name", flat=True)


def gerente_or_manager_required(view_func):
    """
    Decorador para asegurar que solo los usuarios del grupo 'Gerente' o los superusuarios puedan acceder a la vista.
    Si no tienen los permisos requeridos, se devuelve un error 403.
    """
    from django.contrib.auth.decorators import user_passes_test
    return user_passes_test(user_is_gerente_or_manager, login_url=None)(view_func)


@seller_required
@login_required
def ventas(request):
    employe = request.user
    products = Producto.objects.all()
    search_query = request.GET.get("search", "")
    user_groups = request.user.groups.values_list("name", flat=True)
    low_stock_products = Producto.objects.filter(stock__lte=25, activo=True).order_by('-created_at')

    if search_query:
        products = products.filter(nombre__icontains=search_query)

    context = {
        "empleado": employe,
        'low_stock_products': low_stock_products,
        "productos": products,
        "es_almacen": "Almacen" in user_groups,
        "es_vendedor": "Vendedor" in user_groups,
    }

    return render(request, "ventas/register_sale.html", context)

@seller_required
@login_required
def get_producto(request, producto_id):
    try:
        product = Producto.objects.get(id_producto=producto_id)
    except Producto.DoesNotExist:
        return JsonResponse({"error": "Producto no encontrado"}, status=404)

    product_data = {
        "nombre": product.nombre,
        "precio": product.precio,
        "categoria": product.categoria.nombre_categoria,
        "image": product.image.url,
        "descripcion": (
            product.descripcion if product.descripcion else "Sin descripción"
        ),
        "descuento": (
            product.descuento
            if product.descuento is not None and product.descuento > 0
            else 0
        ),
    }
    return JsonResponse(product_data)

@seller_required
@login_required
def process_sale(request):
    if request.method == "POST":
        try:
            # Intentar cargar los datos JSON
            data = json.loads(request.body)

            employee = request.user

            # Validar datos
            if not data.get("products") or not data.get("total"):
                return JsonResponse(
                    {"success": False, "message": "Datos incompletos"}, status=400
                )

            # Validar que el total sea un número positivo
            try:
                total = Decimal(str(data["total"]))
                if total <= 0:
                    return JsonResponse(
                        {
                            "success": False,
                            "message": "El total debe ser mayor que cero",
                        },
                        status=400,
                    )
            except (ValueError, TypeError):
                return JsonResponse(
                    {"success": False, "message": "El total debe ser un número válido"},
                    status=400,
                )

            # Método de pago
            payment_method = data.get("payment_method", "CASH")

            # Crear la venta
            sale = Venta.objects.create(
                empleado=employee, total=total, metodo_pago=payment_method, fecha=timezone.now()
            )
            # Crear número de factura
            parte_fecha = datetime.now().strftime("%Y")
            numero_factura = f"EF{parte_fecha}-{str(sale.id_venta).zfill(6)}"
            # Crear la factura
            factura = Factura.objects.create(venta=sale, numero_factura=numero_factura)

            # Obtener productos en una sola consulta
            product_ids = [item["id"] for item in data["products"]]
            products = Producto.objects.filter(id_producto__in=product_ids)
            products_dict = {product.id_producto: product for product in products}

            # Guardar detalles de la venta
            for item in data["products"]:
                product_id = item["id"]
                if product_id not in products_dict:
                    return JsonResponse(
                        {
                            "success": False,
                            "message": f"Producto con ID {product_id} no encontrado",
                        },
                        status=404,
                    )

                product = products_dict[product_id]

                quantity = Decimal(item["quantity"])
                if product.stock < int(quantity):
                    return JsonResponse(
                        {
                            "success": False,
                            "message": f"Stock insuficiente para {product.nombre}",
                        },
                        status=400,
                    )

                discount = item["discount"]
                unit_price = Decimal(str(item["price"]))
                subtotal = quantity * unit_price
                tax = subtotal * Decimal("0.18")

                # Verificar si el descuento es 0 o tiene un valor distinto de nulo o vacío
                if discount and Decimal(discount) != 0:
                    DetalleVenta.objects.create(
                        venta=sale,
                        producto=product,
                        cantidad=int(quantity),
                        precio_unitario=unit_price,
                        subtotal=subtotal,
                        itbis=tax,
                        descuento=True,
                        cantidad_descuento=Decimal(discount),
                    )
                else:
                    DetalleVenta.objects.create(
                        venta=sale,
                        producto=product,
                        cantidad=int(quantity),
                        precio_unitario=unit_price,
                        subtotal=subtotal,
                        itbis=tax,
                    )
            return JsonResponse(
                {
                    "success": True,
                    "message": "Venta registrada exitosamente",
                    "sale_id": sale.id_venta,
                }
            )

        except json.JSONDecodeError:
            return JsonResponse(
                {"success": False, "message": "Datos inválidos. JSON mal formado."},
                status=400,
            )
        except Exception as e:
            return JsonResponse(
                {"success": False, "message": f"Error inesperado: {str(e)}"}, status=500
            )

    return JsonResponse(
        {"success": False, "message": "Método no permitido"}, status=405
    )
    
    

@seller_required
@login_required
def process_transfer(request):
    if request.method == "POST":
        try:
            data = request.POST

            # Validar datos
            required_fields = [
                "name",
                "phone",
                "email",
                "reference",
                "bank",
                "monto",
                "tipo_cuenta",
            ]
            if not all(data.get(field) for field in required_fields):
                return JsonResponse(
                    {"success": False, "message": "Faltan datos obligatorios"},
                    status=400,
                )

            transfer_amount = Decimal(data.get("monto"))
            if transfer_amount <= 0:
                return JsonResponse(
                    {"success": False, "message": "El monto debe ser mayor a cero"},
                    status=400,
                )

            # Crear venta y transferencia
            employee = request.user
            sale = Venta.objects.create(
                empleado=employee,
                total=transfer_amount,
                metodo_pago="TRANSFERENCIA",
                fecha=now(),
            )
            # Crear número de factura
            parte_fecha = datetime.now().strftime("%Y") if True else ""
            numero_factura = f"TR{parte_fecha}-{str(sale.id_venta).zfill(6)}"
            # Crear la factura
            factura = Factura.objects.create(venta=sale, numero_factura=numero_factura)
            
            transfer = Transferencia.objects.create(
                venta=sale,
                numero_referencia=data.get("reference"),
                banco_emisor=data.get("bank"),
                nombre_cliente=data.get("name"),
                telefono_cliente=data.get("phone"),
                correo_cliente=data.get("email"),
                tipo_cuenta=data.get("tipo_cuenta"),
            )

            # Procesar productos (si los hay)
            products_json = data.get("products")
            if products_json:
                products_data = json.loads(products_json)
                product_ids = [int(item["id"]) for item in products_data]
                products = Producto.objects.filter(id_producto__in=product_ids)
                products_dict = {p.id_producto: p for p in products}

                for item in products_data:
                    product_id = int(item["id"])
                    if product_id not in products_dict:
                        return JsonResponse(
                            {
                                "success": False,
                                "message": f"Producto con ID {product_id} no encontrado",
                            },
                            status=404,
                        )

                    product = products_dict[product_id]
                    quantity = Decimal(item["quantity"])
                    if product.stock < int(quantity):
                        return JsonResponse(
                            {
                                "success": False,
                                "message": f"Stock insuficiente para {product.nombre}",
                            },
                            status=400,
                        )

                    total_price = Decimal(str(item["price"]))
                    unit_price = total_price / quantity
                    subtotal = quantity * unit_price
                    itbis = subtotal * Decimal("0.18")

                    discount = item.get("discount", 0)
                    DetalleVenta.objects.create(
                        venta=sale,
                        producto=product,
                        cantidad=int(quantity),
                        precio_unitario=unit_price,
                        subtotal=subtotal,
                        itbis=itbis,
                        descuento=bool(discount),
                        cantidad_descuento=discount if discount else 0,
                    )

            return JsonResponse(
                {
                    "success": True,
                    "message": "La transferencia y venta se registraron correctamente",  # Mensaje corregido
                    "sale_id": int(sale.id_venta),
                    "transfer_id": int(transfer.pk),
                }
            )
        except Exception as e:
            return JsonResponse(
                {"success": False, "message": f"Error inesperado: {str(e)}"}, status=500
            )

    return JsonResponse(
        {"success": False, "message": "Método no permitido"}, status=405
    )

@seller_required
@login_required
def process_card_payment(request):
    if request.method == "POST":
        try:
            data = request.POST

            # Validar datos obligatorios
            required_fields = ["stripeToken", "total", "products"]
            if not all(data.get(field) for field in required_fields):
                return JsonResponse(
                    {"success": False, "message": "Faltan datos obligatorios"},
                    status=400,
                )

            total_decimal = Decimal(data.get("total"))
            if total_decimal <= 0:
                return JsonResponse(
                    {"success": False, "message": "El monto debe ser mayor a cero"},
                    status=400,
                )

            products_list = json.loads(data.get("products"))
            if not products_list:
                return JsonResponse(
                    {"success": False, "message": "No hay productos en la compra"},
                    status=400,
                )

            # Calcular total con ITBIS
            calculated_subtotal = sum(
                Decimal(str(item["price"])) for item in products_list
            )
            itbis_total = calculated_subtotal * Decimal("0.18")
            calculated_total_with_itbis = (calculated_subtotal + itbis_total).quantize(
                Decimal("0.01"), rounding=ROUND_HALF_UP
            )

            if calculated_total_with_itbis != total_decimal:
                return JsonResponse(
                    {
                        "success": False,
                        "message": "El total no coincide con los productos",
                    },
                    status=400,
                )

            # Crear cargo en Stripe
            charge = stripe.Charge.create(
                amount=int(total_decimal * 100),
                currency="usd",
                source=data.get("stripeToken"),
                description="Pago con tarjeta en POS",
            )

            # Crear venta
            sale = Venta.objects.create(
                empleado=request.user,
                total=total_decimal,
                metodo_pago="TARJETA",
                fecha=timezone.now(),
            )
            # Crear número de factura
            parte_fecha = datetime.now().strftime("%Y") if True else ""
            numero_factura = f"T{parte_fecha}-{str(sale.id_venta).zfill(6)}"
            # Crear la factura
            factura = Factura.objects.create(venta=sale, numero_factura=numero_factura)


            # Obtener productos desde la BD
            product_ids = [int(item["id"]) for item in products_list]
            products_db = Producto.objects.filter(id_producto__in=product_ids)
            products_dict = {p.id_producto: p for p in products_db}

            # Procesar productos
            for item in products_list:
                product_id = int(item["id"])
                product = products_dict.get(product_id)
                if not product:
                    return JsonResponse(
                        {
                            "success": False,
                            "message": f"Producto con ID {product_id} no encontrado",
                        },
                        status=404,
                    )

                quantity = int(item["quantity"])
                if product.stock < quantity:
                    return JsonResponse(
                        {
                            "success": False,
                            "message": f"Stock insuficiente para {product.nombre}",
                        },
                        status=400,
                    )

                total_price = Decimal(str(item["price"]))
                unit_price = total_price / quantity
                subtotal = total_price
                itbis = subtotal * Decimal("0.18")
                discount = item.get("discount", 0)

                DetalleVenta.objects.create(
                    venta=sale,
                    producto=product,
                    cantidad=quantity,
                    precio_unitario=unit_price,
                    subtotal=subtotal,
                    itbis=itbis,
                    descuento=bool(discount),
                    cantidad_descuento=discount if discount else 0,
                )

            return JsonResponse(
                {
                    "success": True,
                    "message": "El pago y la venta se registraron correctamente",
                    "sale_id": int(sale.id_venta),
                    "charge_id": charge.id,
                }
            )

        except stripe.error.CardError as e:
            return JsonResponse(
                {"success": False, "message": f"Error con la tarjeta: {str(e)}"},
                status=400,
            )
        except json.JSONDecodeError:
            return JsonResponse(
                {"success": False, "message": "Error en los datos de productos"},
                status=400,
            )
        except ValueError:
            return JsonResponse(
                {"success": False, "message": "Error en los datos enviados"}, status=400
            )
        except Exception as e:
            return JsonResponse(
                {"success": False, "message": f"Error inesperado: {str(e)}"}, status=500
            )

    return JsonResponse(
        {"success": False, "message": "Método no permitido"}, status=405
    )

@login_required
def descargar_factura_pdf(request, sale_id):
    # Obtiene la factura asociada con la venta
    factura = get_object_or_404(Factura, venta_id=sale_id)
    
    # Calcula los totales para evitar problemas en la plantilla
    detalles = factura.venta.detalles.all()
    total_subtotal = sum(detalle.subtotal for detalle in detalles)
    total_itbis = sum(detalle.itbis for detalle in detalles)
    total_descuento = sum(detalle.cantidad_descuento for detalle in detalles)
    
    # Prepara el contexto para la plantilla
    context = {
        'factura': factura,
        'total_subtotal': total_subtotal,
        'total_itbis': total_itbis,
        'total_descuento': total_descuento,
    }
    
    # Genera el contenido PDF a partir de la plantilla
    pdf_content = render_to_pdf("ventas/bill_pdf.html", context)
    
    if pdf_content:
        # Responde con el archivo PDF para descarga
        response = HttpResponse(pdf_content, content_type='application/pdf')
        filename = f"Factura_{factura.numero_factura}.pdf"
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


def sales_statistics(request):
    filter_type = request.GET.get('filtro', 'mensual')
    now = timezone.now()

    if filter_type == 'diario':
        start_date = datetime(now.year, now.month, now.day, 0, 0, 0)
        end_date = start_date + timedelta(days=1)

    elif filter_type == 'semanal':
        start_date = now - timedelta(days=now.weekday())  # Monday
        start_date = datetime(start_date.year, start_date.month, start_date.day, 0, 0, 0)
        end_date = start_date + timedelta(days=7)  # until Sunday night

    else:  # mensual
        start_date = datetime(now.year, now.month, 1, 0, 0, 0)
        if now.month == 12:
            end_date = datetime(now.year + 1, 1, 1, 0, 0, 0)
        else:
            end_date = datetime(now.year, now.month + 1, 1, 0, 0, 0)

    # Filter sales between start_date and end_date
    sales = Venta.objects.filter(fecha__gte=start_date, fecha__lt=end_date)

    total_sales = sales.count()
    total_earnings = sum(s.total for s in sales)

    sale_details = DetalleVenta.objects.filter(venta__in=sales)
    top_product = sale_details.values('producto__nombre').annotate(
        total_sold=Sum('cantidad')
    ).order_by('-total_sold').first()

    return JsonResponse({
        'total_ventas': total_sales,
        'total_ganancias': float(total_earnings),
        'producto_mas_vendido': top_product['producto__nombre'] if top_product else '',
    })


def income_expenses_data(request):
    filtro = request.GET.get('filtro', None)
    print(f"Filtro recibido: {filtro}")

    today = timezone.localtime(timezone.now())
    print(f"Fecha y hora actual: {today}")

    # Definir rango de fechas según el filtro
    if filtro == "mensual":
        first_day = today.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        last_day = (first_day + timedelta(days=32)).replace(day=1, hour=23, minute=59, second=59, microsecond=999999) - timedelta(days=1)
        print(f"Rango mensual: {first_day} a {last_day}")
    elif filtro == "semanal":
        first_day = today - timedelta(days=today.weekday())  # Lunes
        last_day = first_day + timedelta(days=6)  # Domingo
        first_day = first_day.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = last_day.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango semanal: {first_day} a {last_day}")
    elif filtro == "diario":
        first_day = today.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = today.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango diario: {first_day} a {last_day}")
    else:
        print("Filtro no reconocido. Retornando datos vacíos.")
        return JsonResponse({'labels': [], 'ingresos': [], 'egresos': []})

    # Ingresos
    ingresos = Venta.objects.filter(
        fecha__gte=first_day, fecha__lte=last_day
    ).values('fecha__date').annotate(total=Sum('total')).order_by('fecha__date')
    print(f"Ingresos encontrados: {list(ingresos)}")

    # Egresos
    egresos = DetalleVenta.objects.filter(
        venta__fecha__gte=first_day, venta__fecha__lte=last_day
    ).values('venta__fecha__date').annotate(
        total=Sum(F('cantidad') * F('producto__costo'))
    ).order_by('venta__fecha__date')
    print(f"Egresos encontrados: {list(egresos)}")

    # Crear listas para los datos
    fechas_ingresos = {
        d['fecha__date'] or today.date(): float(d['total']) for d in ingresos
    }
    fechas_egresos = {
        d['venta__fecha__date'] or today.date(): float(d['total']) for d in egresos
    }
    print(f"Diccionario de ingresos por fecha: {fechas_ingresos}")
    print(f"Diccionario de egresos por fecha: {fechas_egresos}")

    # Unificar fechas
    todas_fechas = sorted(set(fechas_ingresos.keys()) | set(fechas_egresos.keys()))
    print(f"Todas las fechas combinadas: {todas_fechas}")

    labels = [fecha.strftime('%Y-%m-%d') for fecha in todas_fechas if fecha is not None]
    ingresos_data = [fechas_ingresos.get(fecha, 0) for fecha in todas_fechas]
    egresos_data = [fechas_egresos.get(fecha, 0) for fecha in todas_fechas]
    print(f"Labels: {labels}")
    print(f"Datos de ingresos: {ingresos_data}")
    print(f"Datos de egresos: {egresos_data}")

    data = {
        'labels': labels,
        'ingresos': ingresos_data,
        'egresos': egresos_data,
    }
    return JsonResponse(data)

def top_products_data(request):
    filtro = request.GET.get('filtro', None)
    print(f"Filtro recibido: {filtro}")

    today = timezone.localtime(timezone.now())
    print(f"Fecha y hora actual: {today}")

    # Definir rango de fechas según el filtro
    if filtro == "mensual":
        first_day = today.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        last_day = (first_day + timedelta(days=32)).replace(day=1, hour=23, minute=59, second=59, microsecond=999999) - timedelta(days=1)
        print(f"Rango mensual: {first_day} a {last_day}")
    elif filtro == "semanal":
        first_day = today - timedelta(days=today.weekday())  # Lunes
        last_day = first_day + timedelta(days=6)  # Domingo
        first_day = first_day.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = last_day.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango semanal: {first_day} a {last_day}")
    elif filtro == "diario":
        first_day = today.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = today.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango diario: {first_day} a {last_day}")
    else:
        print("Filtro no reconocido. Retornando datos vacíos.")
        return JsonResponse({'labels': [], 'data': []})

    # Filtrar productos más vendidos en el rango de fechas
    top_productos = DetalleVenta.objects.filter(
        venta__fecha__gte=first_day, venta__fecha__lte=last_day
    ).values('producto__nombre').annotate(total=Sum('cantidad')).order_by('-total')[:5]

    print(f"Top productos encontrados: {list(top_productos)}")

    data = {
        'labels': [p['producto__nombre'] for p in top_productos],
        'data': [int(p['total']) for p in top_productos],  # Cantidad es entero
    }
    print(f"Datos preparados para la respuesta: {data}")

    return JsonResponse(data)
def sales_by_categories(request):
    filter_value = request.GET.get('filtro', None)
    print(f"Filtro recibido: {filter_value}")

    today = timezone.localtime(timezone.now())
    print(f"Fecha y hora actual: {today}")

    # Definir rango de fechas según el filtro
    if filter_value == "mensual":
        first_day = today.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        last_day = (first_day + timedelta(days=32)).replace(day=1, hour=23, minute=59, second=59, microsecond=999999) - timedelta(days=1)
        print(f"Rango mensual: {first_day} a {last_day}")
    elif filter_value == "semanal":
        first_day = today - timedelta(days=today.weekday())  # Lunes
        last_day = first_day + timedelta(days=6)  # Domingo
        first_day = first_day.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = last_day.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango semanal: {first_day} a {last_day}")
    elif filter_value == "diario":
        first_day = today.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = today.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango diario: {first_day} a {last_day}")
    else:
        print("Filtro no reconocido. Retornando datos vacíos.")
        return JsonResponse({'labels': [], 'data': []})

    # Filtrar ventas por categoría en el rango de fechas
    sales = DetalleVenta.objects.filter(
        venta__fecha__gte=first_day, venta__fecha__lte=last_day
    ).values('producto__categoria__nombre_categoria').annotate(total=Sum('subtotal'))

    print(f"Ventas agrupadas por categoría: {list(sales)}")

    total_sales = sum(float(v['total']) for v in sales)
    print(f"Total de ventas en el período: {total_sales}")

    data = {
        'labels': [v['producto__categoria__nombre_categoria'] for v in sales],
        'data': [float(v['total']) / total_sales * 100 if total_sales > 0 else 0 for v in sales],
    }
    print(f"Datos preparados para la respuesta: {data}")

    return JsonResponse(data)
def chart_data(request):
    filter_value = request.GET.get('filtro', None)
    print(f"Filtro recibido: {filter_value}")

    today = timezone.localtime(timezone.now())  # Fecha y hora actual con zona horaria
    print(f"Fecha y hora actual: {today}")

    # Inicializar la variable ventas
    sales = None

    if filter_value == "mensual":
        first_day_mes = today.replace(day=1)
        last_day_mes = (first_day_mes + timedelta(days=32)).replace(day=1) - timedelta(days=1)
        print(f"Rango mensual: {first_day_mes} a {last_day_mes}")
        sales = Venta.objects.filter(fecha__gte=first_day_mes, fecha__lte=last_day_mes)

    elif filter_value == "semanal":
        first_day_semana = today - timedelta(days=today.weekday())  # Lunes
        last_day_semana = first_day_semana + timedelta(days=6)  # Domingo
        first_day_semana = first_day_semana.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day_semana = last_day_semana.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango semanal: {first_day_semana} a {last_day_semana}")
        sales = Venta.objects.filter(fecha__gte=first_day_semana, fecha__lte=last_day_semana)

    elif filter_value == "diario":
        first_day = today.replace(hour=0, minute=0, second=0, microsecond=0)
        last_day = today.replace(hour=23, minute=59, second=59, microsecond=999999)
        print(f"Rango diario: {first_day} a {last_day}")
        sales = Venta.objects.filter(fecha__gte=first_day, fecha__lte=last_day)

    else:
        print("Filtro no válido. Retornando listas vacías.")
        return JsonResponse({"labels": [], "values": []})

    # Procesar ventas si existen
    if sales:
        if sales.exists():
            print(f"Cantidad de ventas encontradas: {sales.count()}")
            labels = [sale.fecha.strftime('%d-%m-%Y') for sale in sales]
            values = [str(sale.total) for sale in sales]
            print(f"Fechas: {labels}")
            print(f"Totales: {values}")
        else:
            print("No se encontraron ventas en el rango de fechas.")
            labels = []
            values = []
    else:
        print("No se pudo asignar un queryset de ventas.")
        labels = []
        values = []

    return JsonResponse({
        "labels": labels,
        "values": values
    })
def sale_pdf(request):
    print("Iniciando generación de reporte PDF...")

    # Fecha actual
    current_date = timezone.now()
    print(f"Fecha actual: {current_date}")

    # Calcular inicio y fin del mes
    start_of_month = current_date.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
    end_of_month = start_of_month + relativedelta(months=1) - timedelta(seconds=1)
    print(f"Inicio del mes: {start_of_month}, Fin del mes: {end_of_month}")

    # Verificar presencia de datos
    total_ventas = Venta.objects.count()
    print(f"Total de ventas en la base de datos: {total_ventas}")
    
    earliest_sale = Venta.objects.order_by('fecha').first()
    latest_sale = Venta.objects.order_by('-fecha').first()
    print(f"Fecha más antigua: {earliest_sale.fecha if earliest_sale else 'Ninguna'}")
    print(f"Fecha más reciente: {latest_sale.fecha if latest_sale else 'Ninguna'}")
    
    # Ventas del mes actual usando rango
    ventas_this_month = Venta.objects.filter(
        fecha__gte=start_of_month,
        fecha__lte=end_of_month
    ).count()
    print(f"Ventas en el mes actual: {ventas_this_month}")

    # Ingresos
    income_total = Venta.objects.filter(
        fecha__gte=start_of_month,
        fecha__lte=end_of_month
    ).aggregate(total=Sum('total'))['total'] or 0
    print(f"Ingresos del mes: {income_total}")

    # Egresos
    expense_total = DetalleVenta.objects.filter(
        venta__fecha__gte=start_of_month,
        venta__fecha__lte=end_of_month
    ).annotate(
        costo_total=ExpressionWrapper(
            F('cantidad') * F('producto__costo'),
            output_field=DecimalField()
        )
    ).aggregate(total=Sum('costo_total'))['total'] or 0
    print(f"Egresos del mes: {expense_total}")

    # Top 5 productos más vendidos
    top_products = DetalleVenta.objects.filter(
        venta__fecha__gte=start_of_month,
        venta__fecha__lte=end_of_month
    ).values('producto__nombre').annotate(
        total_sold=Sum('cantidad')
    ).order_by('-total_sold')[:5]

    # Calcular porcentaje para top productos
    total_sold_all = DetalleVenta.objects.filter(
        venta__fecha__gte=start_of_month,
        venta__fecha__lte=end_of_month
    ).aggregate(total=Sum('cantidad'))['total'] or 0
    top_products = [
        {
            'producto__nombre': p['producto__nombre'],
            'total_sold': p['total_sold'],
            'percentage': (p['total_sold'] / total_sold_all * 100) if total_sold_all > 0 else 0
        }
        for p in top_products
    ]
    print("Top 5 productos más vendidos:")
    for p in top_products:
        print(f" - {p['producto__nombre']}: {p['total_sold']} unidades ({p['percentage']:.1f}%)")

    # Ventas por categoría
    sales_by_category = DetalleVenta.objects.filter(
        venta__fecha__gte=start_of_month,
        venta__fecha__lte=end_of_month
    ).values('producto__categoria__nombre_categoria').annotate(
        total_sales=Sum('subtotal')
    ).order_by('-total_sales')

    # Calcular porcentaje para ventas por categoría
    total_sales_all = income_total  # Usamos income_total como base para el porcentaje
    sales_by_category = [
        {
            'producto__categoria__nombre_categoria': c['producto__categoria__nombre_categoria'],
            'total_sales': c['total_sales'],
            'percentage': (c['total_sales'] / total_sales_all * 100) if total_sales_all > 0 else 0
        }
        for c in sales_by_category
    ]
    print("Ventas por categoría:")
    for c in sales_by_category:
        print(f" - {c['producto__categoria__nombre_categoria']}: ${c['total_sales']} ({c['percentage']:.1f}%)")

    # Generación del HTML desde la plantilla
    print("Generando contenido HTML desde la plantilla...")
    context = {
        'current_date': current_date,
        'income_total': income_total,
        'expense_total': expense_total,
        'balance': income_total - expense_total,
        'top_products': top_products,
        'sales_by_category': sales_by_category,
    }
    html_string = render_to_string('ventas/sales_report.html', context)

    print("Convirtiendo HTML a PDF con WeasyPrint...")
    pdf_file = BytesIO()
    HTML(string=html_string).write_pdf(pdf_file)
    pdf_file.seek(0)

    print("Preparando respuesta HTTP con el PDF adjunto...")
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="reporte_ventas_{current_date.strftime("%Y_%m")}.pdf"'
    response.write(pdf_file.read())

    print("Reporte generado exitosamente.")
    return response