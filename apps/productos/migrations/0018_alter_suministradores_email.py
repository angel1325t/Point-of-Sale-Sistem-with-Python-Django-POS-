# Generated by Django 5.1.6 on 2025-03-28 00:55

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("productos", "0017_alter_suministradores_email_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="suministradores",
            name="email",
            field=models.EmailField(max_length=254, unique=True),
        ),
    ]
