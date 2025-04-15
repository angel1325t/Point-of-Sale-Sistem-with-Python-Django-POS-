from django.db import models
from django.core.validators import MinValueValidator
from django.core.exceptions import ValidationError

class Devolucion(models.Model):
    factura = models.ForeignKey(
        'ventas.Factura',
        on_delete=models.CASCADE,
        related_name='devoluciones',
        help_text="Factura asociada a esta devolución"
    )
    
    fecha_devolucion = models.DateTimeField(
        auto_now_add=True,
        help_text="Fecha en que se registró la devolución"
    )
    
    MOTIVOS_DEVOLUCION = (
        ('DEFECTUOSO', 'Producto defectuoso'),
        ('DAÑADO', 'Producto dañado'),
        ('OTRO', 'Otro motivo'),
    )
    
    motivo_general = models.CharField(
        max_length=20,
        choices=MOTIVOS_DEVOLUCION,
        default='OTRO',
        help_text="Motivo principal de la devolución"
    )
    
    METODOS_REEMBOLSO = (
        ('ORIGINAL', 'Método original de pago'),
        ('CREDITO', 'Crédito en tienda'),
        ('TRANSFERENCIA', 'Transferencia bancaria'),
        ('EFECTIVO', 'Efectivo'),
    )
    
    metodo_reembolso = models.CharField(
        max_length=20,
        choices=METODOS_REEMBOLSO,
        default='ORIGINAL',
        help_text="Método utilizado para el reembolso"
    )
    
    subtotal = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Subtotal de los productos devueltos"
    )
    
    impuesto = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        default=0.0,
        help_text="Impuesto aplicado (ej. ITBIS)"
    )
    
    descuento = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        default=0.0,
        help_text="Descuentos aplicados a la devolución"
    )
    
    total_devolver = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Total a devolver al cliente"
    )
    
    comentarios = models.TextField(
        blank=True,
        null=True,
        help_text="Detalles adicionales sobre la devolución"
    )
    
    def save(self, *args, **kwargs):
        # Validar que no exista otra devolución para la misma factura
        if self.pk is None:  # Solo para nuevas devoluciones
            if Devolucion.objects.filter(factura=self.factura).exists():
                raise ValidationError("Ya existe una devolución para esta factura.")
        
        # Calcular el total a devolver automáticamente
        self.total_devolver = self.subtotal + self.impuesto - self.descuento
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Devolución #{self.id} - Factura {self.factura.numero_factura}"

    class Meta:
        verbose_name = "Devolución"
        verbose_name_plural = "Devoluciones"


class DetalleDevolucion(models.Model):
    devolucion = models.ForeignKey(
        'Devolucion',
        on_delete=models.CASCADE,
        related_name='detalles',
        help_text="Devolución a la que pertenece este detalle"
    )
    
    producto = models.ForeignKey(
        'productos.Producto',
        on_delete=models.SET_NULL,
        null=True,
        related_name='devoluciones',
        help_text="Producto que se está devolviendo"
    )
    
    cantidad = models.PositiveIntegerField(
        validators=[MinValueValidator(1)],
        help_text="Cantidad de unidades devueltas"
    )
    
    precio_unitario = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Precio unitario del producto"
    )
    
    inventario_repuesto = models.BooleanField(
        default=False,
        help_text="Marca si ya se repuso el inventario por esta devolución"
    )
    
    motivo = models.CharField(
        max_length=20,
        choices=Devolucion.MOTIVOS_DEVOLUCION,
        default='OTRO',
        help_text="Motivo específico para la devolución de este producto"
    )

    def __str__(self):
        return f"{self.cantidad} x {self.producto} (Devolución #{self.devolucion.id})"

    class Meta:
        verbose_name = "Detalle de Devolución"
        verbose_name_plural = "Detalles de Devoluciones"

