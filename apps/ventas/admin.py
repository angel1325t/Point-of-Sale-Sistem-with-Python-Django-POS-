from django.db.models import Sum, Count
from django.contrib import admin
from .models import Venta, DetalleVenta
@admin.register(Venta)
class VentaAdmin(admin.ModelAdmin):
    def changelist_view(self, request, extra_context=None):
        if extra_context is None:
            extra_context = {}

        total_ventas = Venta.objects.count()
        total_ganancias = Venta.objects.aggregate(Sum("total"))["total__sum"] or 0

        # Get the best-selling product from DetalleVenta
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
        # Prevent showing the "Add Venta" button
        return False    