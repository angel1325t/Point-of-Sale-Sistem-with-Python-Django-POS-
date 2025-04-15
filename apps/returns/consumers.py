from channels.generic.websocket import AsyncWebsocketConsumer
import json
from asgiref.sync import sync_to_async
from datetime import timedelta
from django.utils import timezone

class StockConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        print("WebSocket conectado con éxito")
        await self.channel_layer.group_add("stock_group", self.channel_name)
        await self.accept()
        print("Conexión aceptada para:", self.channel_name)

        from apps.productos.models import Producto

        # Traer productos con stock bajo y activos
        productos_bajo_stock = await sync_to_async(list)(
            Producto.objects.filter(stock__lte=25, activo=True)
        )

        ahora = timezone.now()
        intervalo = timedelta(hours=6) 

        for producto in productos_bajo_stock:
            # Verifica si ya se envió una alerta recientemente
            if not producto.ultima_alerta_stock or ahora - producto.ultima_alerta_stock > intervalo:
                if producto.stock == 0:
                    mensaje = f"❌ Producto agotado: {producto.nombre} (Stock: 0)"
                else:
                    mensaje = f"⚠️ Stock bajo: {producto.nombre} (Stock: {producto.stock})"

                print(f"Enviando al cliente {self.channel_name}: {mensaje}")
                await self.send(text_data=json.dumps({
                    'message': mensaje
                }))
                print(f"Mensaje enviado al cliente {self.channel_name}")

                # Actualizar el tiempo de última alerta
                producto.ultima_alerta_stock = ahora
                await sync_to_async(producto.save)()
