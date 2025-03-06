from django.shortcuts import render
from django.http import JsonResponse
from ..productos.models import Producto
from django.shortcuts import get_object_or_404
def ventas(request):
    empleado = request.user
    productos = Producto.objects.all()
    search_query = request.GET.get('search', '')

    if search_query:
        productos = productos.filter(nombre__icontains=search_query)


    context = {
        'empleado': empleado,
        'productos': productos,
    }

    return render(request, 'test/prueba.html', context)

from django.http import JsonResponse

def get_producto(request, producto_id):
    print(f"Producto ID recibido: {producto_id}")
    try:
        producto = Producto.objects.get(id_producto=producto_id)
    except Producto.DoesNotExist:
        print(f"Producto con id {producto_id} no encontrado.")
        return JsonResponse({"error": "Producto no encontrado"}, status=404)

    producto_data = {
        'nombre': producto.nombre,
        'precio': producto.precio,
        'categoria': producto.categoria.nombre_categoria,
        'image': producto.image.url,
        'descripcion': producto.descripcion if producto.descripcion else 'Sin descripción',
    }
    return JsonResponse(producto_data)

