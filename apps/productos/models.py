import json
import qrcode
from io import BytesIO
from django.db import models
from django.core.files import File
from PIL import Image

def upload_to(instance, filename):
    return f'productos_img/{filename}'

class Categoria(models.Model):
    id_categoria = models.AutoField(primary_key=True)
    nombre_categoria = models.CharField(max_length=255, unique=True)
    descripcion_categoria = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.nombre_categoria

class Producto(models.Model):
    id_producto = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255)
    descripcion = models.TextField(null=True, blank=True)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.PositiveIntegerField()
    image = models.ImageField(upload_to=upload_to, default='productos_img/no_image.jpg', null=True, blank=True)
    activo = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    marca = models.TextField(null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE, related_name='productos')
    codigo_qr = models.ImageField(upload_to='qrcodes/', null=True, blank=True)

    def save(self, *args, **kwargs):
        # Primero guardamos el objeto para que se asigne un id
        super().save(*args, **kwargs)

        # Generamos los datos para el QR code usando los atributos del objeto
        qr_data = json.dumps({
            "id": self.id_producto,
            "name": self.nombre,
            "category": self.categoria.nombre_categoria if self.categoria else "",
            "price": float(self.precio),
            "stock": self.stock,
            "image": self.image
        })

        # Si aún no tiene código QR, lo generamos
        if not self.codigo_qr:
            qr = qrcode.QRCode(
                version=1,
                error_correction=qrcode.constants.ERROR_CORRECT_L,
                box_size=10,  # Ajustado para obtener ~203 píxeles de ancho
                border=4     # Quiet zone necesaria
            )
            qr.add_data(qr_data)
            qr.make(fit=True)

            qr_img = qr.make_image(fill_color='black', back_color='white')

            # Aseguramos que sea una imagen PIL
            if not isinstance(qr_img, Image.Image):
                qr_img = qr_img.convert("RGB")

            # Guardamos la imagen QR en memoria
            qr_io = BytesIO()
            qr_img.save(qr_io, format='PNG')
            qr_io.seek(0)
            qr_file = File(qr_io, name=f'producto_{self.id_producto}_qr.png')

            # Asignamos el archivo generado al campo codigo_qr
            self.codigo_qr.save(f'producto_{self.id_producto}_qr.png', qr_file, save=False)

            # Guardamos nuevamente el objeto con el QR generado
            super().save(update_fields=['codigo_qr'])

    def __str__(self):
        return self.nombre
