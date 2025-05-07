# Sistema de Punto de Venta (POS)

## Introducción

Esta aplicación web es un sistema de punto de venta (POS) diseñado para gestionar de manera eficiente las ventas, el inventario y los clientes. Permite registrar productos, procesar transacciones y generar reportes en tiempo real.

Gracias a su interfaz intuitiva y funcionalidades clave como la gestión de usuarios, historial de ventas y control de stock, esta solución facilita la administración del negocio y mejora la toma de decisiones.

Además, automatiza procesos, reduce errores manuales y mejora la eficiencia operativa mediante reportes actualizados en tiempo real.

---

## Características Principales

- Gestión de productos e inventario
- Registro de ventas y devoluciones
- Control de stock en tiempo real
- Gestión de usuarios con roles personalizados
- Generación de reportes y estadísticas de ventas
- Panel de administración integrado (Django Admin)

---

## Tecnologías Utilizadas

### Front-end

- **Lenguajes:**

  - HTML
  - CSS
  - JavaScript
- **Frameworks y librerías:**

  - Tailwind CSS
  - Flowbite
  - Google Fonts
  - Font Awesome
  - Heroicons
  - MerakiUI
  - WickedBlocks
  - Django Templates
  - UnDraw (ilustraciones)
  - Django-Jazmin (estilos personalizados para el admin)

### Back-end

- **Lenguajes y frameworks:**

  - Django (Python)
  - MySQL
- **Servicios y APIs:**

  - Hunter.io (verificación de correos electrónicos)
  - Stripe (procesamiento de pagos)
  - Chart.js (gráficas dinámicas)
  - Gmail API (envío automático de correos)
  - HTML5-QRCode (escaneo de códigos QR en tiempo real)

---

## Variables de Entorno

Para el correcto funcionamiento del sistema, asegúrate de definir las siguientes variables de entorno:

- `STRIPE_SECRET_KEY`: Clave privada de Stripe
- `HUNTER_API_KEY`: Clave para verificar correos con Hunter.io
- `GMAIL_CLIENT_ID`
- `GMAIL_CLIENT_SECRET`
- `GMAIL_REFRESH_TOKEN`

> Puedes almacenarlas en un archivo `.env` y cargarlas con `python-decouple` o `os.environ`.

---

## Instalación y Configuración

1. **Clonar el repositorio:**

```bash
git clone https://github.com/tuusuario/tu-repositorio.git
cd tu-repositorio
```

2. **Crear y activar el entorno virtual:**

```bash
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

3. **Instalar las dependencias:**

```bash
pip install -r requirements.txt
```

4. **Configurar la base de datos y aplicar migraciones:**

Edita `settings.py` con tus datos de conexión y luego ejecuta:

```bash
python manage.py migrate
```

5. **Crear superusuario para el panel administrativo:**

```bash
python manage.py createsuperuser
```

6. **Ejecutar el servidor de desarrollo:**

```bash
python manage.py runserver
```

7. **Acceder a la aplicación:**

Visita [http://127.0.0.1:8000/](http://127.0.0.1:8000/) en tu navegador.

---

## Documentación de APIs Integradas

### Hunter.io (Verificación de Correos Electrónicos)

- **Propósito:** Validar correos electrónicos durante el registro.
- **Uso:** Se envía el correo a la API y se analiza la respuesta para determinar su validez.

### Stripe (Pagos con Tarjeta)

- **Propósito:** Procesamiento de pagos de forma segura.
- **Uso:**
  - Integración en modo sandbox para pruebas.
  - Creación de sesiones de pago y manejo de respuestas.

### Chart.js (Gráficos)

- **Propósito:** Visualizar estadísticas en el dashboard.
- **Uso:** Se renderizan gráficos en un elemento `<canvas>` mediante JavaScript.

### Gmail API (Envío de Correos)

- **Propósito:** Automatizar notificaciones por correo.
- **Uso:** Requiere credenciales OAuth 2.0 de Google Cloud y permite el envío programado de mensajes.

### HTML5-QRCode (Escaneo de QR)

- **Propósito:** Escaneo de códigos QR desde la cámara del dispositivo.
- **Uso:** Ideal para registrar productos rápidamente desde el punto de venta.
