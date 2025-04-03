from django.contrib.auth.models import AbstractUser
from django.db import models
from django.apps import apps  # Para obtener los modelos dinámicamente
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.contrib.auth.models import Group
from django.contrib.auth import get_user_model
import uuid

class CustomUser(AbstractUser):
    profile_image = models.ImageField(upload_to='profile_pics/',default='profile_pics/default_profile.png')

    group = models.ForeignKey(
        Group, 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True, 
        related_name="customuser_set"
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


User = get_user_model()

class EmailVerificationToken(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.UUIDField(default=uuid.uuid4, editable=False)
    new_email = models.EmailField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_verified = models.BooleanField(default=False)

    class Meta:
        unique_together = ('user', 'token')