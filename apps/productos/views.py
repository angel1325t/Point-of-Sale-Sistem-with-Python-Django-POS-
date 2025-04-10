from django.db.models import Prefetch
from .models import Producto, Categoria, MovimientoProducto
from django.core.paginator import Paginator
from django.shortcuts import render,get_object_or_404
from .forms import AddProductForm
from django.contrib import messages
from django.shortcuts import redirect
from django.contrib.auth.decorators import login_required

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

@inventory_required
@login_required
def product_view(request):
    empleado = request.user
    user_groups = request.user.groups.values_list("name", flat=True)

    # Definir el Prefetch para movimientos, ordenados por fecha
    movements_prefetch = Prefetch(
        'movimientos',
        queryset=MovimientoProducto.objects.order_by('-fecha'),
        to_attr='last_movements'
    )
    # Obtener productos activos con movimientos precargados
    products_list = Producto.objects.filter(activo=True).prefetch_related(movements_prefetch)

    # Paginación
    paginator = Paginator(products_list, 5)
    page_number = request.GET.get('page')
    products = paginator.get_page(page_number)

    # Obtener categorías
    categories = Categoria.objects.all()

    # Contexto para el template
    context = {
        'products': products,
        'categories': categories,
        'empleado': empleado,
        "es_almacen": "Almacen" in user_groups,
        "es_vendedor": "Vendedor" in user_groups,
    }

    return render(request, 'products/products.html', context)