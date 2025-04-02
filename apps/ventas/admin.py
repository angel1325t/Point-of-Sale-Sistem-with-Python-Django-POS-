from django.contrib import admin
from django.urls import path
from django.template.response import TemplateResponse
from .models import Venta
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
        extra_context["show_chart"] = True  # Pasar variable a la plantilla
        return super().changelist_view(request, extra_context=extra_context)
