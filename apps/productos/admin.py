from django.utils.html import format_html
from django.contrib import admin
from .models import Producto, Categoria
from .forms import AddProductForm, CategoriaForm  # Importa los formularios

# Registro de Categoria en el admin
@admin.register(Categoria)
class CategoriaAdmin(admin.ModelAdmin):
    form = CategoriaForm  # Usa el formulario correcto para Categoria
    list_display = ('id_categoria', 'nombre_categoria', 'descripcion_categoria')
    search_fields = ('nombre_categoria',)
    list_filter = ('nombre_categoria',)
    ordering = ('nombre_categoria',)
    list_per_page = 5

# Registro de Producto en el admin
class ProductAdmin(admin.ModelAdmin):
    form = AddProductForm  # Usa el formulario correcto para Producto
    list_display = ('nombre', 'marca', 'precio', 'stock', 'activo', 'imagen_preview', 'descripcion', 'categoria') 
    search_fields = ('nombre', 'descripcion', 'marca','id_producto')
    list_filter = ('activo', 'created_at', 'categoria')  # Filtrar
    ordering = ('-created_at',)
    list_editable = ['activo'] # Campos editables directamente desde la lista
    list_per_page = 5
    fieldsets = (
        (None, {
            'fields': ('nombre', 'marca', 'descripcion','image', 'activo', 'categoria')
        }),
        ('Precios y stock', {
            'fields': ('precio', 'stock')
        }),
    )

    def imagen_preview(self, obj):
        if obj.image:
            return format_html('<img src="{}" width="50" height="50" style="object-fit: cover;" />', obj.image.url)
        return "No Image"
    
    imagen_preview.short_description = 'Imagen'

# Registra ambos modelos en el admin
admin.site.register(Producto, ProductAdmin)
