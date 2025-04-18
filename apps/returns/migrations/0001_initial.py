# Generated by Django 5.1.6 on 2025-04-09 20:34

import django.core.validators
import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("productos", "0021_alter_movimientoproducto_tipo_movimiento"),
        ("ventas", "0011_factura"),
    ]

    operations = [
        migrations.CreateModel(
            name="Devolucion",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "fecha_devolucion",
                    models.DateTimeField(
                        auto_now_add=True,
                        help_text="Fecha en que se registró la devolución",
                    ),
                ),
                (
                    "motivo_general",
                    models.CharField(
                        choices=[
                            ("DEFECTUOSO", "Producto defectuoso"),
                            ("DAÑADO", "Producto dañado"),
                            ("OTRO", "Otro motivo"),
                        ],
                        default="OTRO",
                        help_text="Motivo principal de la devolución",
                        max_length=20,
                    ),
                ),
                (
                    "metodo_reembolso",
                    models.CharField(
                        choices=[
                            ("ORIGINAL", "Método original de pago"),
                            ("CREDITO", "Crédito en tienda"),
                            ("TRANSFERENCIA", "Transferencia bancaria"),
                            ("EFECTIVO", "Efectivo"),
                        ],
                        default="ORIGINAL",
                        help_text="Método utilizado para el reembolso",
                        max_length=20,
                    ),
                ),
                (
                    "subtotal",
                    models.DecimalField(
                        decimal_places=2,
                        help_text="Subtotal de los productos devueltos",
                        max_digits=10,
                        validators=[django.core.validators.MinValueValidator(0.0)],
                    ),
                ),
                (
                    "impuesto",
                    models.DecimalField(
                        decimal_places=2,
                        default=0.0,
                        help_text="Impuesto aplicado (ej. ITBIS)",
                        max_digits=10,
                        validators=[django.core.validators.MinValueValidator(0.0)],
                    ),
                ),
                (
                    "descuento",
                    models.DecimalField(
                        decimal_places=2,
                        default=0.0,
                        help_text="Descuentos aplicados a la devolución",
                        max_digits=10,
                        validators=[django.core.validators.MinValueValidator(0.0)],
                    ),
                ),
                (
                    "total_devolver",
                    models.DecimalField(
                        decimal_places=2,
                        help_text="Total a devolver al cliente",
                        max_digits=10,
                        validators=[django.core.validators.MinValueValidator(0.0)],
                    ),
                ),
                (
                    "comentarios",
                    models.TextField(
                        blank=True,
                        help_text="Detalles adicionales sobre la devolución",
                        null=True,
                    ),
                ),
                (
                    "factura",
                    models.ForeignKey(
                        help_text="Factura asociada a esta devolución",
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="devoluciones",
                        to="ventas.factura",
                    ),
                ),
            ],
            options={
                "verbose_name": "Devolución",
                "verbose_name_plural": "Devoluciones",
            },
        ),
        migrations.CreateModel(
            name="DetalleDevolucion",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "cantidad",
                    models.PositiveIntegerField(
                        help_text="Cantidad de unidades devueltas",
                        validators=[django.core.validators.MinValueValidator(1)],
                    ),
                ),
                (
                    "precio_unitario",
                    models.DecimalField(
                        decimal_places=2,
                        help_text="Precio unitario del producto",
                        max_digits=10,
                        validators=[django.core.validators.MinValueValidator(0.0)],
                    ),
                ),
                (
                    "motivo",
                    models.CharField(
                        choices=[
                            ("DEFECTUOSO", "Producto defectuoso"),
                            ("DAÑADO", "Producto dañado"),
                            ("OTRO", "Otro motivo"),
                        ],
                        default="OTRO",
                        help_text="Motivo específico para la devolución de este producto",
                        max_length=20,
                    ),
                ),
                (
                    "producto",
                    models.ForeignKey(
                        help_text="Producto que se está devolviendo",
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="devoluciones",
                        to="productos.producto",
                    ),
                ),
                (
                    "devolucion",
                    models.ForeignKey(
                        help_text="Devolución a la que pertenece este detalle",
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="detalles",
                        to="returns.devolucion",
                    ),
                ),
            ],
            options={
                "verbose_name": "Detalle de Devolución",
                "verbose_name_plural": "Detalles de Devoluciones",
            },
        ),
    ]
