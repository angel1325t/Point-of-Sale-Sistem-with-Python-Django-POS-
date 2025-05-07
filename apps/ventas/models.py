from django.db import models
from django.conf import settings
from ..productos.models import Producto

class Venta(models.Model):
    METODO_PAGO_CHOICES = [
        ('EFECTIVO', 'Efectivo'),
        ('TARJETA', 'Tarjeta'),
        ('TRANSFERENCIA', 'Transferencia'),
    ]

    id_venta = models.AutoField(primary_key=True)
    empleado = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='ventas',
        limit_choices_to={'is_staff': True} 
    )
    total = models.DecimalField(max_digits=10, decimal_places=2)
    fecha = models.DateTimeField(auto_now_add=True)
    metodo_pago = models.CharField(max_length=20, choices=METODO_PAGO_CHOICES)

    def __str__(self):
        return f"Venta #{self.id_venta} - {self.empleado.username} - {self.total}"

class Transferencia(models.Model):
    TIPO_CUENTA_CHOICES = [
        ('CORRIENTE', 'Cuenta Corriente'),
        ('AHORROS', 'Cuenta de Ahorros'),
    ]
    venta = models.OneToOneField(Venta, on_delete=models.CASCADE, related_name='transferencia')
    numero_referencia = models.CharField(max_length=20)
    banco_emisor = models.CharField(max_length=100)
    nombre_cliente = models.CharField(max_length=255)
    telefono_cliente = models.CharField(max_length=15)
    correo_cliente = models.EmailField()
    tipo_cuenta = models.CharField(max_length=20, choices=TIPO_CUENTA_CHOICES)

    def __str__(self):
        return f"Transferencia para Venta #{self.venta.id_venta} - Ref: {self.numero_referencia}"

class DetalleVenta(models.Model):
    id_detalle = models.AutoField(primary_key=True)
    venta = models.ForeignKey(
        Venta,
        on_delete=models.CASCADE,
        related_name='detalles'
    )
    producto = models.ForeignKey(
        Producto,
        on_delete=models.CASCADE
    )
    cantidad = models.PositiveIntegerField()
    precio_unitario = models.DecimalField(max_digits=10, decimal_places=2)
    subtotal = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="Se recomienda almacenar la cantidad * precio_unitario"
    )
    itbis = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        help_text="ITBIS calculado como el 18% del subtotal"
    )
    descuento = models.BooleanField(
        default=False,
        help_text="Indica si se aplica un descuento a este detalle de venta"
    )
    cantidad_descuento = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0.00,
        help_text="Monto del descuento aplicado"
    )

    def __str__(self):
        return f"{self.producto.nombre} - {self.cantidad} unidades"

class Factura(models.Model):
    venta = models.OneToOneField(
        Venta,
        on_delete=models.CASCADE,
        related_name='factura'
    )
    numero_factura = models.CharField(
        max_length=20,
        unique=True,
        help_text="Ej: F-000001"
    )
    fecha_emision = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Factura {self.numero_factura} - Venta #{self.venta.id_venta}"
