import os
from django.db.models.signals import post_delete
from django.dispatch import receiver
from django.conf import settings
from .models import Producto

@receiver(post_delete, sender=Producto)
def eliminar_archivos_producto(sender, instance, **kwargs):
    # Eliminar el código QR
    if instance.codigo_qr:
        qr_path = instance.codigo_qr.path
        if os.path.isfile(qr_path):
            os.remove(qr_path)

    # Eliminar la imagen principal
    if instance.image and instance.image.name != 'productos_img/no_image.jpg':  # No borrar la imagen por defecto
        image_path = instance.image.path
        if os.path.isfile(image_path):
            os.remove(image_path)
