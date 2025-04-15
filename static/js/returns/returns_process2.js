// Función para obtener el token CSRF
function getCsrfToken() {
    return document.querySelector('[name=csrfmiddlewaretoken]').value;
}
// Escuchar el evento submit del formulario
document.getElementById('return-form').addEventListener('submit', function(event) {
    event.preventDefault(); // Prevenir el envío por defecto

    const submitButton = document.getElementById('submit-return-btn');
    submitButton.disabled = true;
    submitButton.classList.add('opacity-75');

    showLoader(); // Solo mostrar el loader si las validaciones pasan

    // Recopilar datos del formulario
    const formData = new FormData(this);

    // Enviar los datos al servidor
    fetch("/empleados/procesar_devolucion/", {
        method: 'POST',
        body: formData,
        headers: {
            'X-CSRFToken': getCsrfToken()
        }
    })
    .then(response => {
        if (!response.ok) {
            return response.json().then(data => {
                throw new Error(data.message || 'Error en el servidor.');
            });
        }
        return response.json();
    })
    .then(data => {
        hideLoader();
        if (data.success) {
            Swal.fire({
                icon: 'success',
                title: '¡Devolución Procesada!',
                text: data.message || 'La devolución se registró correctamente.',
                confirmButtonText: 'OK'
            }).then(() => {
                // Redirige al PDF del comprobantexx
                window.location.href = `/empleados/devoluciones/${data.devolucion_id}/pdf/`;
    
                // Después de un pequeño retraso, redirige a otra página
                setTimeout(() => {
                    window.location.href = '/empleados/devoluciones';
                }, 2000);
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: data.message || 'Hubo un problema al procesar la devolución.',
                confirmButtonText: 'Intentar de nuevo'
            });
        }
        submitButton.disabled = false;
        submitButton.classList.remove('opacity-75');
    })
    .catch(error => {
        hideLoader();
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: error.message || 'No se pudo conectar con el servidor. Intenta de nuevo.',
            confirmButtonText: 'OK'
        });
        console.error('Error en la solicitud:', error);
        submitButton.disabled = false;
        submitButton.classList.remove('opacity-75');
    });
});