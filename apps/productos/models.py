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


# Modelo Suministradores con opciones Meta
class Suministradores(models.Model):
    provedor_id = models.AutoField(primary_key=True)
    nombre_proveedor = models.CharField(max_length=255, unique=True)
    telefono = models.CharField(max_length=20)
    email = models.EmailField(unique=True)
    direccion = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Suministrador"
        verbose_name_plural = "Suministradores"

    def __str__(self):
        return self.nombre_proveedor
class Producto(models.Model):
    id_producto = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=255)
    descripcion = models.TextField(null=True, blank=True)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    costo = models.DecimalField(max_digits=10, decimal_places=2)
    descuento = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    stock = models.PositiveIntegerField()
    image = models.ImageField(upload_to=upload_to, default='productos_img/no_image.jpg', null=True, blank=True)
    activo = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    marca = models.TextField(null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True)
    categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE, related_name='productos')
    suministrador = models.ForeignKey(Suministradores, on_delete=models.CASCADE, related_name='productos')
    codigo_qr = models.ImageField(upload_to='qrcodes/', null=True, blank=True)

    def save(self, *args, **kwargs):
        # Si el objeto ya existe, verifica cambios en stock
        if self.pk is not None:
            original = Producto.objects.get(pk=self.pk)

            if self.stock < original.stock:
                # Si el stock disminuyó, evitar actualizar updated_at
                kwargs['update_fields'] = ['stock']
                super().save(*args, **kwargs)
                return

        # Guardar normalmente si hay cambios en otros campos o stock aumenta
        super().save(*args, **kwargs)

        # Generar código QR solo si no existe
        if not self.codigo_qr:
            qr_data = json.dumps({
                "id": self.id_producto,
                "name": self.nombre,
                "category": self.categoria.nombre_categoria if self.categoria else "",
                "supplier": self.suministrador.nombre_proveedor if self.suministrador else "",
                "price": float(self.precio),
                "cost": float(self.costo),
                "discount": float(self.descuento) if self.descuento else 0,
                "stock": self.stock,
                "image": self.image.url if self.image else ""
            })

            qr = qrcode.QRCode(
                version=1,
                error_correction=qrcode.constants.ERROR_CORRECT_L,
                box_size=10,
                border=4
            )
            qr.add_data(qr_data)
            qr.make(fit=True)

            qr_img = qr.make_image(fill_color='black', back_color='white')

            if not isinstance(qr_img, Image.Image):
                qr_img = qr_img.convert("RGB")

            qr_io = BytesIO()
            qr_img.save(qr_io, format='PNG')
            qr_io.seek(0)
            qr_file = File(qr_io, name=f'producto_{self.id_producto}_qr.png')

            self.codigo_qr.save(f'producto_{self.id_producto}_qr.png', qr_file, save=False)
            super().save(update_fields=['codigo_qr'])

    def __str__(self):
        return self.nombre
