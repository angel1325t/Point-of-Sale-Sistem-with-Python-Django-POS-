from django.core.paginator import Paginator
from django.shortcuts import render
from .forms import AddProductForm
from django.contrib import messages
from django.shortcuts import redirect
from .models import Producto, Categoria

# Create your views here.
def add_product_view(request):
    if request.method == 'POST':
        form = AddProductForm(request.POST, request.FILES)
        if form.is_valid():
            try:
                form.save()
            except:
                messages(request, 'Error al guardar el producto')
                return redirect('products')
    return redirect('products')

def product_view(request):
    # Obtener los parámetros de búsqueda y categoría desde la URL
    search_query = request.GET.get('search', '')  # Obtener la búsqueda
    category_filter = request.GET.get('category', '')  # Obtener el filtro de categoría

    # Filtrar los productos por la búsqueda y la categoría
    products_list = Producto.objects.all()

    if search_query:
        products_list = products_list.filter(nombre__icontains=search_query)  # Filtra por nombre

    if category_filter:
        products_list = products_list.filter(categoria__id_categoria=category_filter)  # Filtra por categoría


    paginator = Paginator(products_list, 5)  # Muestra 5 productos por página
    page_number = request.GET.get('page')  # Obtiene el número de página desde la URL
    products = paginator.get_page(page_number)  # Obtiene los productos de la página actual

    # Obtener las categorías disponibles para el filtro (accediendo a los nombres)
    categories = Categoria.objects.all()  # Obtén todos los objetos de Categoria

    context = {
        'products': products,
        'categories': categories,
        'search_query': search_query,
        'category_filter': category_filter
    }

    return render(request, 'products/products.html', context)

