import os
from django.db.models.signals import post_delete
from django.dispatch import receiver
from .models import CustomUser

@receiver(post_delete, sender=CustomUser)
def eliminar_foto_perfil(sender, instance, **kwargs):
    # Verifica si el usuario tiene una imagen de perfil
    if instance.profile_image and 'default_profile.png' not in instance.profile_image.name:
        image_path = instance.profile_image.path
        # Elimina la imagen solo si existe el archivo
        if os.path.isfile(image_path):
            os.remove(image_path)
