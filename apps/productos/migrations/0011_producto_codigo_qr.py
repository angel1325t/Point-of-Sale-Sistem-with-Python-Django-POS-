# Generated by Django 5.1.6 on 2025-03-03 21:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("productos", "0010_alter_producto_categoria"),
    ]

    operations = [
        migrations.AddField(
            model_name="producto",
            name="codigo_qr",
            field=models.ImageField(blank=True, null=True, upload_to="qrcodes/"),
        ),
    ]
