document.addEventListener('DOMContentLoaded', function() {
    // Obtener el token CSRF desde la metaetiqueta
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    
    // Seleccionar todos los botones con la clase 'generate-qr-btn'
    const generateQRBtns = document.querySelectorAll('.generate-qr-btn');
    
    // Iterar sobre cada botón y añadir un evento de clic
    generateQRBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            // Mostrar el loader al iniciar el proceso
            showLoader();
            
            // Obtener el ID del producto y la URL desde los atributos data-
            const productId = btn.dataset.productId;
            const url = btn.dataset.url;
            
            // Obtener el formulario y el modal correspondientes usando el productId
            const form = document.getElementById(`qrForm-${productId}`);
            const modal = document.getElementById(`download-qr-id-${productId}`);
            const formData = new FormData(form);

            // Hacer la solicitud fetch al servidor
            fetch(url, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRFToken': csrfToken
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error en la generación del PDF');
                }
                return response.blob();
            })
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.style.display = 'none';
                a.href = url;
                a.download = `qr_codes_product_${productId}.pdf`; // Nombre dinámico con el ID
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
                modal.classList.add('hidden'); // Cerrar el modal
                // Mostrar alerta de éxito
                Swal.fire({
                    icon: 'success',
                    title: '¡PDF generado!',
                    text: 'El archivo con los códigos QR ha sido descargado exitosamente.',
                    timer: 2000,
                    showConfirmButton: false,
                    willClose: () => {
                        location.reload();
                    }
                });
            })
            .catch(error => {
                console.error('Error:', error);
                // Mostrar alerta de error
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Hubo un problema al generar el PDF. Por favor, intenta de nuevo.',
                });
            })
            .finally(() => {
                // Ocultar el loader cuando el proceso termine (éxito o error)
                hideLoader();
            });
        });
    });
});