from django.utils.html import format_html
from django.contrib import admin
from django import forms
from django.shortcuts import render, redirect
from .models import Producto, Categoria, Suministradores,MovimientoProducto
from .forms import AddProductForm, CategoriaForm, SuministradoresForm

# Formulario para aplicar descuentos
class DiscountForm(forms.Form):
    _selected_action = forms.CharField(widget=forms.MultipleHiddenInput)
    discount = forms.DecimalField(max_digits=5, decimal_places=2, label='Nuevo descuento')

# Registro de Categoria en el admin
@admin.register(Categoria)
class CategoriaAdmin(admin.ModelAdmin):
    form = CategoriaForm
    list_display = ('id_categoria', 'nombre_categoria', 'descripcion_categoria')
    search_fields = ('nombre_categoria',)
    list_filter = ('nombre_categoria',)
    ordering = ('nombre_categoria',)
    list_per_page = 5



@admin.register(MovimientoProducto)
class MovimientoProductoAdmin(admin.ModelAdmin):
    list_display = ('producto', 'tipo_movimiento', 'cantidad', 'stock_antes', 'stock_despues', 'fecha')
    list_filter = ('tipo_movimiento', 'fecha')
    search_fields = ('producto__nombre', 'descripcion')
    ordering = ('-fecha',)


# Registro de Producto en el admin
class ProductAdmin(admin.ModelAdmin):
    form = AddProductForm
    list_display = ('nombre', 'marca', 'precio', 'stock', 'imagen_preview', 'descripcion', 'categoria','suministrador', 'descuento', 'activo') 
    search_fields = ('nombre', 'descripcion', 'marca', 'id_producto')
    list_filter = ('activo', 'created_at', 'categoria','suministrador')
    ordering = ('-created_at',)
    list_editable = ['activo']
    list_per_page = 5
    actions = ['apply_discount']
    
    fieldsets = (
        (None, {
            'fields': ('nombre', 'marca', 'descripcion', 'image', 'activo', 'categoria','suministrador')
        }),
        ('Precios y Descuentos', {
            'fields': ('precio','costo', 'stock', 'descuento')
        }),
    )

    def imagen_preview(self, obj):
        if obj.image:
            return format_html('<img src="{}" width="50" height="50" style="object-fit: cover;" />', obj.image.url)
        return "No Image"
    
    imagen_preview.short_description = 'Imagen'

    # Acción para aplicar descuento
    def apply_discount(self, request, queryset):
        # Depuración para ver los datos enviados
        print("POST data:", request.POST)

        if 'apply' in request.POST:
            form = DiscountForm(request.POST)
            if form.is_valid():
                discount = form.cleaned_data['discount']
                # Obtener los IDs seleccionados del formulario
                selected_ids = request.POST.getlist('_selected_action')
                # Filtrar el queryset con los IDs seleccionados
                queryset = Producto.objects.filter(pk__in=selected_ids)
                updated = queryset.update(descuento=discount)
                self.message_user(request, f"{updated} productos actualizados con un descuento de {discount}%.")
                return redirect(request.get_full_path())
            else:
                selected = request.POST.getlist('_selected_action')
                return render(request, 'admin/discount_form.html', {
                    'form': form,
                    'selected_items': selected,
                })
        else:
            if not queryset.exists():
                self.message_user(request, "No se seleccionaron productos.", level="error")
                return redirect(request.get_full_path())
            
            selected = [str(obj.pk) for obj in queryset]
            form = DiscountForm(initial={'_selected_action': selected})
            return render(request, 'admin/discount_form.html', {
                'form': form,
                'selected_items': selected,
            })

    apply_discount.short_description = "Aplicar Descuento"

# Registra el modelo en el admin
admin.site.register(Producto, ProductAdmin)
# Registro de Suministradores en el admin

@admin.register(Suministradores)
class SuministradoresAdmin(admin.ModelAdmin):
    form = SuministradoresForm
    list_display = ('nombre_proveedor', 'telefono', 'email', 'direccion')
    search_fields = ('nombre_proveedor', 'telefono', 'email')
    list_filter = ('created_at', 'updated_at')
    ordering = ('-created_at',)
    list_per_page = 10
    