# Generated by Django 5.1.6 on 2025-03-25 17:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("ventas", "0009_transferencia_tipo_cuenta"),
    ]

    operations = [
        migrations.AddField(
            model_name="detalleventa",
            name="cantidad_descuento",
            field=models.DecimalField(
                decimal_places=2,
                default=0.0,
                help_text="Monto del descuento aplicado",
                max_digits=10,
            ),
        ),
        migrations.AddField(
            model_name="detalleventa",
            name="descuento",
            field=models.BooleanField(
                default=False,
                help_text="Indica si se aplica un descuento a este detalle de venta",
            ),
        ),
    ]
