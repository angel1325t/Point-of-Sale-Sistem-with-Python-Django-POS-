# Generated by Django 5.1.6 on 2025-04-06 23:52

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("productos", "0019_producto_suministrador"),
    ]

    operations = [
        migrations.CreateModel(
            name="MovimientoProducto",
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
                    "tipo_movimiento",
                    models.CharField(
                        choices=[
                            ("ENTRADA", "Entrada"),
                            ("SALIDA", "Salida"),
                            ("ACTUALIZACION", "Actualización"),
                        ],
                        max_length=20,
                    ),
                ),
                ("cantidad", models.PositiveIntegerField()),
                ("stock_antes", models.PositiveIntegerField()),
                ("stock_despues", models.PositiveIntegerField()),
                ("descripcion", models.TextField(blank=True, null=True)),
                ("fecha", models.DateTimeField(auto_now_add=True)),
                (
                    "producto",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="movimientos",
                        to="productos.producto",
                    ),
                ),
            ],
        ),
    ]
