// Función para procesar el pago
function processCardPayment(token, productsList, totalWithTax, form, payButton) {
    function getCsrfToken() {
        return document.querySelector('[name=csrfmiddlewaretoken]').value;
    }

    // Mostrar loader
    showLoader();

    const formData = new FormData(form);
    formData.set('stripeToken', token.id);
    formData.set('products', JSON.stringify(productsList));
    formData.set('total', totalWithTax.toFixed(2));

    fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRFToken': getCsrfToken()
        }
    })
        .then(response => {
            // Siempre intenta parsear la respuesta como JSON, incluso para códigos de estado no-2xx
            return response.json().then(data => ({ status: response.status, data }));
        })
        .then(({ status, data }) => {
            hideLoader(); // Ocultar loader al completar la solicitud
            if (data.success) {
                Swal.fire({
                    icon: 'success',
                    title: '¡Pago Exitoso!',
                    text: data.message || 'El pago y la venta se registraron correctamente.',
                    confirmButtonText: 'OK'
                }).then(() => {
                    // Redirige a la URL del PDF, después de un pequeño retraso
                    window.location.href = `/empleados/factura/${data.sale_id}/pdf`;
                    
                    // También podrías redirigir a la página de ventas después de la descarga
                    setTimeout(function() {
                        window.location.href = '/empleados'; // Cambia esta URL por la ruta de ventas
                    }, 2000);
                });
            } else {
                // Manejar errores 400, 404, 500, etc., mostrando el mensaje del backend
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: data.message || 'Hubo un problema al procesar el pago.',
                    confirmButtonText: 'Intentar de nuevo'
                });
            }
            payButton.disabled = false;
            payButton.classList.remove("opacity-75");
            payButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                </svg>
                Pagar ahora
            `;
        })
        .catch(error => {
            hideLoader(); // Ocultar loader en caso de error
            Swal.fire({
                icon: 'error',
                title: 'Error de Conexión',
                text: 'No se pudo conectar con el servidor. Por favor, intenta de nuevo.',
                confirmButtonText: 'OK'
            });
            console.error('Error en la solicitud:', error);
            payButton.disabled = false;
            payButton.classList.remove("opacity-75");
            payButton.innerHTML = `
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                </svg>
                Pagar ahora
            `;
        });
}