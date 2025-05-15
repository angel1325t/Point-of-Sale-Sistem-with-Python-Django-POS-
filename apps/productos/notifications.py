from asgiref.sync import async_to_sync
from channels.layers import get_channel_layer

def notificar_stock_bajo(producto):
    print(f"Verificando producto: {producto.nombre}, Stock: {producto.stock}")  # Depuración
    channel_layer = get_channel_layer()

    if producto.stock == 0:
        mensaje = f"❌ Producto agotado: {producto.nombre} (Stock: 0)"
    elif producto.stock <= 25:
        mensaje = f"⚠️ Stock bajo: {producto.nombre} (Stock: {producto.stock})"
    else:
        print("Stock suficiente, no se envía notificación")  # Depuración
        return

    print(f"Enviando al grupo stock_group: {mensaje}")  # Depuración
    async_to_sync(channel_layer.group_send)(
        "stock_group",
        {
            "type": "stock_notification",
            "message": mensaje
        }
    )