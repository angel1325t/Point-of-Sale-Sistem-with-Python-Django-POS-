from django.db import models
from django.core.validators import MinValueValidator

class Devolucion(models.Model):
    # Relación con la factura (una devolución está vinculada a una factura específica)
    factura = models.ForeignKey(
        'ventas.Factura',
        on_delete=models.CASCADE,
        related_name='devoluciones',
        help_text="Factura asociada a esta devolución"
    )
    
    # Fecha de la devolución
    fecha_devolucion = models.DateTimeField(
        auto_now_add=True,
        help_text="Fecha en que se registró la devolución"
    )
    
    # Motivos predefinidos para la devolución
    MOTIVOS_DEVOLUCION = (
        ('DEFECTUOSO', 'Producto defectuoso'),
        ('DAÑADO', 'Producto dañado'),
        ('OTRO', 'Otro motivo'),
    )
    
    # Campo para el motivo general de la devolución
    motivo_general = models.CharField(
        max_length=20,
        choices=MOTIVOS_DEVOLUCION,
        default='OTRO',
        help_text="Motivo principal de la devolución"
    )
    
    # Métodos de reembolso disponibles
    METODOS_REEMBOLSO = (
        ('ORIGINAL', 'Método original de pago'),
        ('CREDITO', 'Crédito en tienda'),
        ('TRANSFERENCIA', 'Transferencia bancaria'),
        ('EFECTIVO', 'Efectivo'),
    )
    
    # Método de reembolso seleccionado
    metodo_reembolso = models.CharField(
        max_length=20,
        choices=METODOS_REEMBOLSO,
        default='ORIGINAL',
        help_text="Método utilizado para el reembolso"
    )
    
    # Subtotal de los productos devueltos (sin impuestos ni descuentos)
    subtotal = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Subtotal de los productos devueltos"
    )
    
    # Impuesto aplicado (ej. ITBIS 18%)
    impuesto = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        default=0.0,
        help_text="Impuesto aplicado (ej. ITBIS)"
    )
    
    # Descuentos aplicados a la devolución (si aplica)
    descuento = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        default=0.0,
        help_text="Descuentos aplicados a la devolución"
    )
    
    # Total a devolver
    total_devolver = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Total a devolver al cliente"
    )
    
    # Comentarios adicionales
    comentarios = models.TextField(
        blank=True,
        null=True,
        help_text="Detalles adicionales sobre la devolución"
    )
    
    def save(self, *args, **kwargs):
        # Calcular el total a devolver automáticamente antes de guardar
        self.total_devolver = self.subtotal + self.impuesto - self.descuento
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Devolución #{self.id} - Factura {self.factura.numero_factura}"

    class Meta:
        verbose_name = "Devolución"
        verbose_name_plural = "Devoluciones"


class DetalleDevolucion(models.Model):
    # Relación con la devolución principal
    devolucion = models.ForeignKey(
        'Devolucion',
        on_delete=models.CASCADE,
        related_name='detalles',
        help_text="Devolución a la que pertenece este detalle"
    )
    
    # Producto devuelto (suponiendo que existe un modelo Producto)
    producto = models.ForeignKey(
        'productos.Producto',  # Ajusta esto según el nombre de tu modelo de Producto
        on_delete=models.SET_NULL,
        null=True,
        related_name='devoluciones',
        help_text="Producto que se está devolviendo"
    )
    
    # Cantidad devuelta
    cantidad = models.PositiveIntegerField(
        validators=[MinValueValidator(1)],
        help_text="Cantidad de unidades devueltas"
    )
    
    # Precio unitario del producto al momento de la devolución
    precio_unitario = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        validators=[MinValueValidator(0.0)],
        help_text="Precio unitario del producto"
    )
    
    # Motivo específico para este producto
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