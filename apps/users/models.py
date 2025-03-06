from django.contrib.auth.models import AbstractUser
from django.db import models
from django.apps import apps  # Para obtener los modelos dinámicamente
from django.db.models.signals import post_save
from django.dispatch import receiver

class CustomUser(AbstractUser):
    profile_image = models.ImageField(upload_to='profile_pics/', blank=True, null=True)
    is_client = models.BooleanField(default=False, null=True, blank=True)

    groups = models.ManyToManyField(
        'auth.Group', 
        related_name='customuser_set',
        blank=True
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='customuser_set',
        blank=True
    )

    # Asegura que el correo sea único
    email = models.EmailField(unique=True)

    def save(self, *args, **kwargs):
        self.email = self.email.lower()  # Convierte el correo a minúsculas
        super(CustomUser, self).save(*args, **kwargs)
