# Generated by Django 5.1.6 on 2025-03-10 18:59

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("productos", "0013_producto_codigo_qr"),
        ("ventas", "0004_remove_venta_cliente_remove_venta_empleado_and_more"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Venta",
            fields=[
                ("id_venta", models.AutoField(primary_key=True, serialize=False)),
                ("total", models.DecimalField(decimal_places=2, max_digits=10)),
                ("fecha", models.DateTimeField(auto_now_add=True)),
                (
                    "metodo_pago",
                    models.CharField(
                        choices=[
                            ("EFECTIVO", "Efectivo"),
                            ("TARJETA", "Tarjeta"),
                            ("TRANSFERENCIA", "Transferencia"),
                        ],
                        max_length=20,
                    ),
                ),
                (
                    "empleado",
                    models.ForeignKey(
                        limit_choices_to={"is_staff": True},
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="ventas",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="DetalleVenta",
            fields=[
                ("id_detalle", models.AutoField(primary_key=True, serialize=False)),
                ("cantidad", models.PositiveIntegerField()),
                (
                    "precio_unitario",
                    models.DecimalField(decimal_places=2, max_digits=10),
                ),
                (
                    "subtotal",
                    models.DecimalField(
                        decimal_places=2,
                        help_text="Se recomienda almacenar la cantidad * precio_unitario",
                        max_digits=10,
                    ),
                ),
                (
                    "producto",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="productos.producto",
                    ),
                ),
                (
                    "venta",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="detalles",
                        to="ventas.venta",
                    ),
                ),
            ],
        ),
    ]
