from django.db.models import Sum, Count
from django.contrib import admin
from django.urls import path
from django.template.response import TemplateResponse
from .models import Venta, DetalleVenta
from .views import chart_data  # Asegúrate de que la vista 'chart_data' esté importada si se necesita

class CustomAdminSite(admin.AdminSite):
    def get_urls(self):
        urls = super().get_urls()
        extra_urls = [
            path("chart/", self.admin_view(self.chart_view)),  # Añadimos el path para el gráfico
        ]
        return extra_urls + urls

    def chart_view(self, request):
        # Llamar al template con el gráfico
        return TemplateResponse(request, "admin/ventas/venta/charts.html", {})

admin_site = CustomAdminSite(name="admin")

@admin.register(Venta)
class VentaAdmin(admin.ModelAdmin):
    def changelist_view(self, request, extra_context=None):
        if extra_context is None:
            extra_context = {}

        total_ventas = Venta.objects.count()
        total_ganancias = Venta.objects.aggregate(Sum("total"))["total__sum"] or 0

        # Aquí cambiamos a DetalleVenta
        producto_mas_vendido = (
            DetalleVenta.objects.values("producto__nombre")
            .annotate(total=Sum("cantidad"))
            .order_by("-total")
            .first()
        )

        extra_context["show_chart"] = True
        extra_context["total_ventas"] = total_ventas
        extra_context["total_ganancias"] = total_ganancias
        extra_context["producto_mas_vendido"] = producto_mas_vendido["producto__nombre"] if producto_mas_vendido else "N/A"

        return super().changelist_view(request, extra_context=extra_context)
    def has_add_permission(self, request):
        # Evita que se muestre el botón "Agregar Venta"
        return False
