from django.db.models import Prefetch
from .models import Producto, Categoria, MovimientoProducto
from django.core.paginator import Paginator
from django.shortcuts import render,get_object_or_404
from django.contrib import messages
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required
from django.db.models import Q
from django.http import HttpResponse
from django.template.loader import render_to_string
import qrcode
from weasyprint import HTML
import base64
from io import BytesIO
import json

def user_is_not_seller(user):
    # Verifica si el usuario NO pertenece al grupo 'Vendedor'
    return "Vendedor" not in user.groups.values_list("name", flat=True)

def inventory_required(view_func):
    """
    Decorador que permite acceso a todos los usuarios excepto los del grupo 'Vendedor'.
    Si pertenecen a 'Vendedor', se devuelve un error 403.
    """
    from django.contrib.auth.decorators import user_passes_test
    return user_passes_test(user_is_not_seller, login_url=None)(view_func)


@inventory_required
@login_required
def update_product(request, product_id):
    product = get_object_or_404(Producto, id_producto=product_id)
    
    if request.method == "POST":
        description = request.POST.get("description")
        price = request.POST.get("price")
        stock_str = request.POST.get("stock")
        profile_image = request.FILES.get("profile_image")
        
        cambios_realizados = False

        # Actualizar descripción
        if description and description != product.descripcion:
            product.descripcion = description
            cambios_realizados = True
        
        # Actualizar precio
        if price:
            try:
                price = float(price)
                if price < 0:
                    messages.error(request, "El precio no puede ser negativo.")
                    return redirect("products")
                if price != product.precio:
                    product.precio = price
                    cambios_realizados = True
            except ValueError:
                messages.error(request, "Ingrese un precio válido.")
                return redirect("products")
        
        # Actualizar stock
        if stock_str:
            try:
                stock = int(stock_str)
                if stock < 0:
                    messages.error(request, "El stock no puede ser negativo.")
                    return redirect("products")
                if stock < product.stock:
                    messages.error(request, "El nuevo stock no puede ser menor al stock actual.")
                    return redirect("products")
                if stock != product.stock:
                    product.stock = stock
                    cambios_realizados = True
            except ValueError:
                messages.error(request, "Ingrese un valor válido para el stock.")
                return redirect("products")
        
        # Actualizar imagen
        if profile_image:
            product.image = profile_image
            cambios_realizados = True
        
        # Guardar cambios si los hay
        if cambios_realizados:
            product.save()
            messages.success(request, "Producto actualizado exitosamente.")
        else:
            messages.info(request, "No se realizaron cambios en el producto.")

        return redirect("products")
    
    return render(request, "products/products.html", {"product": product})  


@login_required
@inventory_required
def product_view(request):
    empleado = request.user
    user_groups = request.user.groups.values_list("name", flat=True)

    # Definir el Prefetch para movimientos, ordenados por fecha
    movements_prefetch = Prefetch(
        'movimientos',
        queryset=MovimientoProducto.objects.order_by('-fecha'),
        to_attr='last_movements'
    )

    # Base queryset for active products
    products_list = Producto.objects.filter(activo=True).prefetch_related(movements_prefetch)

    # Apply filters from GET parameters
    search = request.GET.get('search', '')
    category = request.GET.get('category', '')
    order_by = request.GET.get('order_by', '')
    estado = request.GET.get('estado', '')
    precio_min = request.GET.get('precio_min', '')
    precio_max = request.GET.get('precio_max', '')

    # Filter by search (name, description, or brand)
    if search:
        products_list = products_list.filter(
            Q(nombre__icontains=search) |
            Q(descripcion__icontains=search) |
            Q(marca__icontains=search)
        )

    # Filter by category
    if category:
        products_list = products_list.filter(categoria_id=category)

    # Filter by estado (stock status)
    if estado:
        if estado == 'en_stock':
            products_list = products_list.filter(stock__gt=25)
        elif estado == 'bajo_stock':
            products_list = products_list.filter(stock__lte=25, stock__gt=0)
        elif estado == 'agotado':
            products_list = products_list.filter(stock=0)

    # Filter by price range
    if precio_min:
        try:
            products_list = products_list.filter(precio__gte=float(precio_min))
        except ValueError:
            pass
    if precio_max:
        try:
            products_list = products_list.filter(precio__lte=float(precio_max))
        except ValueError:
            pass

    # Apply ordering
    if order_by:
        if order_by == 'nombre_asc':
            products_list = products_list.order_by('nombre')
        elif order_by == 'nombre_desc':
            products_list = products_list.order_by('-nombre')
        elif order_by == 'precio_asc':
            products_list = products_list.order_by('precio')
        elif order_by == 'precio_desc':
            products_list = products_list.order_by('-precio')

    # Paginación
    paginator = Paginator(products_list, 5)
    page_number = request.GET.get('page')
    products = paginator.get_page(page_number)

    # Obtener categorías y productos con bajo stock
    categories = Categoria.objects.all()
    low_stock_products = Producto.objects.filter(stock__lte=25, activo=True).order_by('-created_at')

    # Contexto para el template

    context = {
        'low_stock_products': low_stock_products,
        'products': products,
        'categories': categories,
        'empleado': empleado,
        'es_almacen': 'Almacen' in user_groups,
        'es_vendedor': 'Vendedor' in user_groups,
        'search': search,
        'category': category,
        'order_by': order_by,
        'estado': estado,
        'precio_min': precio_min,
        'precio_max': precio_max,
    }

    return render(request, 'products/products.html', context)
def generate_qr_pdf(request, product_id):
    product = get_object_or_404(Producto, id_producto=product_id)

    if request.method == 'POST':
        qr_quantity = int(request.POST.get('qrQuantity', 1))
        qr_pixel_size = 256  # Tamaño fijo de 256px

        # Generar los datos JSON para el QR
        qr_data = json.dumps({
            "id": product.id_producto,
            "name": product.nombre,
            "category": product.categoria.nombre_categoria if product.categoria else "",
            "supplier": product.suministrador.nombre_proveedor if product.suministrador else "",
            "price": float(product.precio),
            "cost": float(product.costo),
            "discount": float(product.descuento) if product.descuento else 0,
            "stock": product.stock,
            "image": product.image.url if product.image else ""
        })

        # Generar las imágenes QR en base64
        qr_images = []
        for _ in range(qr_quantity):
            qr = qrcode.QRCode(
                version=1,
                error_correction=qrcode.constants.ERROR_CORRECT_L,
                box_size=10,  # Controls pixel density
                border=4,
            )
            qr.add_data(qr_data)
            qr.make(fit=True)
            qr_img = qr.make_image(fill_color="black", back_color="white")

            buffered = BytesIO()
            qr_img = qr_img.resize((qr_pixel_size, qr_pixel_size))  # Resize a tamaño fijo
            qr_img.save(buffered, format="PNG")
            qr_base64 = base64.b64encode(buffered.getvalue()).decode('utf-8')
            qr_images.append({'base64': qr_base64})

        # Renderizar el template HTML
        context = {
            'qr_images': qr_images,
            'product': product,
        }
        html_string = render_to_string('products/qr_pdf_template.html', context)

        # Generar el PDF
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = f'attachment; filename="qr_codes_product_{product_id}.pdf"'
        HTML(string=html_string).write_pdf(response)

        return response
    else:
        return HttpResponse("Método no permitido", status=405)