# Generated by Django 5.1.6 on 2025-04-06 23:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("users", "0008_emailverificationtoken"),
    ]

    operations = [
        migrations.AlterField(
            model_name="customuser",
            name="profile_image",
            field=models.ImageField(
                default="profile_pics/default_profile.png", upload_to="profile_pics/"
            ),
        ),
    ]
