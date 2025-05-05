# Sistema de Punto de Venta (POS)

## Introducción

La aplicación web es un sistema de punto de venta (POS) diseñado para gestionar ventas, inventario y clientes de manera eficiente. Permite a los usuarios registrar productos, procesar transacciones y generar reportes en tiempo real.

Con una interfaz intuitiva y funciones clave como gestión de usuarios, historial de ventas y control de stock, esta aplicación facilitará la administración de un negocio y mejorará la toma de decisiones.

Esta aplicación de punto de venta optimizará la gestión de ventas e inventario, permitiendo automatizar procesos, reducir errores manuales y mejorar la eficiencia operativa. Además, proporciona reportes en tiempo real para la toma de decisiones basada en datos precisos.

## Requerimientos Funcionales

### Front-end:

- Panel para realizar ventas rápidas con escaneo de códigos de barras.
- Gestión de productos, categorías y precios dinámicos.
- Interfaz para aplicar descuentos y promociones.
- Integración de métodos de pago (efectivo, tarjeta, transferencia).

### Back-end:

- Base de datos para productos, transacciones y clientes.
- Algoritmo para calcular descuentos automáticos y promociones.
- API para gestionar reportes de ventas en tiempo real.
- Análisis de ventas por hora, día y producto más vendido.

### Requerimientos Generales:

- Diseño Responsivo (adaptado a cada pantalla).
- Login y Registro de usuarios.
- Integración de inteligencia artificial.
- Manual técnico y de usuario (PDF).
- Documentación del progreso del desarrollo.
- CRUD de todas las entidades de la aplicación (Productos, Usuarios, Empleados).
- Permisos de usuario.
- UI/UX optimizado.
- Reportes e informes sobre ventas y desempeño.

## Tecnologías Implementadas

### Front-end:

- **Tecnologías base:**
  - HTML
  - CSS
  - JavaScript
- **Librerías y herramientas:**
  - Tailwind CSS
  - FlowBite
  - Google Fonts
  - Font Awesome
  - Heroicons
  - MerakiUI
  - Wickedblocks
  - DjangoTemplates
  - UnDraw
  - Django-Jazmín

### Back-end:

- **Tecnologías base:**
  - Django (Python)
  - MySQL
- **Librerías y herramientas:**
  - Hunter.io (API para verificación de correos electrónicos).
  - Stripe (API para pagos con tarjeta).
  - Chart.js (API para generación de gráficos).
  - Gmail API (para envío de correos electrónicos).
  - HTML5-QRCode (para escaneo de códigos QR).

## Documentación de APIs

### 1. **Hunter.io (Verificación de Correos Electrónicos)**

**Descripción:** API que permite verificar direcciones de correo electrónico.

- **Propósito:** Validar direcciones de correo electrónico en registros.
- **Uso:**
  - Se envía la dirección a la API.
  - Se analiza la respuesta y se determina la validez del correo.

### 2. **Stripe (Pagos con Tarjeta)**

**Descripción:** API para procesamiento de pagos con tarjeta.

- **Propósito:** Gestionar pagos de forma segura.
- **Uso:**
  - Integración en modo sandbox para pruebas.
  - Creación de sesiones de pago.
  - Manejo de respuestas de éxito o fallo.

### 3. **Chart.js (Generación de Gráficos)**

**Descripción:** API para visualización de datos en gráficos interactivos.

- **Propósito:** Representar datos clave en el dashboard.
- **Uso:**
  - Configuración de gráficos en el front-end.
  - Uso de `canvas` en HTML5 para renderización.

### 4. **Gmail API (Envío de Correos Electrónicos)**

**Descripción:** API de Google para envío de correos.

- **Propósito:** Automatizar el envío de notificaciones y confirmaciones.
- **Uso:**
  - Configuración de credenciales en Google Cloud.
  - Autenticación y envío de correos programáticamente.

### 5. **HTML5-QRCode (Escaneo de Códigos QR)**

**Descripción:** Librería en JavaScript para escaneo de QR en tiempo real.

- **Propósito:** Capturar códigos QR desde la cámara del dispositivo.
- **Uso:**
  - Integración de la librería en el proyecto.
  - Configuración de escaneo en la interfaz de ventas.

---

## Instalación y Configuración

1. Clonar el repositorio:		

   ```sh
   git clone https://github.com/tuusuario/tu-repositorio.git
   cd tu-repositorio
   ```
2. Crear y activar entorno virtual:

   ```sh
   python -m venv venv
   source venv/bin/activate  # En Windows: venv\Scripts\activate
   ```
3. Instalar dependencias:

   ```sh
   pip install -r requirements.txt
   ```
4. Configurar la base de datos en `settings.py` y migrar:

   ```sh
   python manage.py migrate
   ```
5. Crear un superusuario para el panel de administración:

   ```sh
   python manage.py createsuperuser
   ```
6. Ejecutar el servidor:

   ```sh
   python manage.py runserver
   ```
7. Acceder a la aplicación en `http://127.0.0.1:8000/`

---

## Contribuciones

Si deseas contribuir al proyecto, ¡serás bienvenido! Por favor, sigue estos pasos:

1. Realiza un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature-nueva-funcionalidad`).
3. Realiza tus cambios y haz commit (`git commit -m 'Agrega nueva funcionalidad'`).
4. Sube los cambios a tu fork (`git push origin feature-nueva-funcionalidad`).
5. Abre un Pull Request en este repositorio.

## Licencia

Este proyecto está bajo la licencia MIT. Puedes ver más detalles en el archivo `LICENSE`.
