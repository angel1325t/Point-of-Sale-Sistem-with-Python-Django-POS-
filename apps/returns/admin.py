from django.contrib import admin
from django.urls import path
from django.template.response import TemplateResponse
from django.http import HttpResponse
from .models import Devolucion, DetalleDevolucion
from django.db.models import Sum
from weasyprint import HTML
from io import BytesIO


@admin.register(Devolucion)
class DevolucionAdmin(admin.ModelAdmin):
    def changelist_view(self, request, extra_context=None):
        if extra_context is None:
            extra_context = {}
        total_devoluciones = Devolucion.objects.count()
        total_devuelto = (
            Devolucion.objects.aggregate(Sum("total_devolver"))["total_devolver__sum"]
            or 0
        )
        producto_mas_devuelto = (
            DetalleDevolucion.objects.values("producto__nombre")
            .annotate(total=Sum("cantidad"))
            .order_by("-total")
            .first()
        )

        extra_context["show_chart"] = True
        extra_context["total_devoluciones"] = total_devoluciones
        extra_context["total_devuelto"] = total_devuelto
        extra_context["producto_mas_devuelto"] = (
            producto_mas_devuelto["producto__nombre"]
            if producto_mas_devuelto
            else "N/A"
        )
        return super().changelist_view(request, extra_context=extra_context)

    def has_add_permission(self, request):
        return False

