document.addEventListener('DOMContentLoaded', function() {
    // Seleccionar todos los modales
    const modals = document.querySelectorAll('[id^="edit-modal-id-"]');
    
    modals.forEach(modal => {
        const modalId = modal.id;
        const closeButton = modal.querySelector('[data-modal-hide]');
        
        // Seleccionar los inputs dentro de este modal específico
        const quantityInput = modal.querySelector(`#quantity-input-${modalId.split('edit-modal-id-')[1]}`);
        const descriptionInput = modal.querySelector('#description');
        const priceInput = modal.querySelector('#price');
        const fileInput = modal.querySelector('#profile_picture');

        // Guardar valores originales exactos del servidor
        const originalValues = {
            quantity: quantityInput?.value || '0',  // Stock por defecto 0 si no hay valor
            description: descriptionInput?.value || '',  // Descripción vacía si no hay valor
            price: priceInput?.value || '',  // Usar el valor original, vacío si no hay nada
            file: ''  // No podemos guardar el valor original del file input por seguridad
        };

        // Función para resetear los inputs a sus valores originales
        function resetInputs() {
            if (quantityInput) quantityInput.value = originalValues.quantity;
            if (descriptionInput) descriptionInput.value = originalValues.description;
            if (priceInput) priceInput.value = originalValues.price;  // Restaurar valor original
            if (fileInput) fileInput.value = '';  // Resetear input file
        }

        // Evento para el botón de cerrar (X)
        if (closeButton) {
            closeButton.addEventListener('click', function() {
                resetInputs();
                modal.classList.add('hidden'); // Ocultar el modal
            });
        }

        // Evento para clic fuera del modal (backdrop)
        modal.addEventListener('click', function(e) {
            // Verificar si el clic fue en el backdrop (fuera del contenido del modal)
            if (e.target === modal) {
                resetInputs();
                modal.classList.add('hidden');
            }
        });
    });
});