# Generated by Django 5.1.6 on 2025-04-12 01:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("returns", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="detalledevolucion",
            name="inventario_repuesto",
            field=models.BooleanField(
                default=False,
                help_text="Marca si ya se repuso el inventario por esta devolución",
            ),
        ),
    ]
