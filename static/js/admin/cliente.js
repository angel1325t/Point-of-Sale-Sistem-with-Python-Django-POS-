document.addEventListener('DOMContentLoaded', function () {
    const cargoField = document.getElementById('id_cargo');
    const direccionField = document.getElementById('id_direccion');
    const cedulaField = document.getElementById('id_cedula');
    const telefonoField = document.getElementById('id_telefono');

    // Función para actualizar la visibilidad de los campos
    function updateFieldVisibility() {
        const isCliente = cargoField.value === 'cliente';

        // Seleccionar las etiquetas y filas directamente
        const direccionLabel = document.querySelector("label[for='id_direccion']");
        const cedulaLabel = document.querySelector("label[for='id_cedula']");
        const telefonoLabel = document.querySelector("label[for='id_telefono']");
        const direccionRow = direccionField.closest('.row');
        const cedulaRow = cedulaField.closest('.row');
        const telefonoRow = telefonoField.closest('.row');

        // Mostrar u ocultar campos según el valor de 'cargoField'
        direccionField.style.display = isCliente ? 'block' : 'none';
        cedulaField.style.display = isCliente ? 'block' : 'none';
        telefonoField.style.display = isCliente ? 'block' : 'none';
        direccionLabel.style.display = isCliente ? '' : 'none';
        cedulaLabel.style.display = isCliente ? '' : 'none';
        telefonoLabel.style.display = isCliente ? '' : 'none';
        direccionRow.style.display = isCliente ? 'flex' : 'none';
        cedulaRow.style.display = isCliente ? 'flex' : 'none';
        telefonoRow.style.display = isCliente ? 'flex' : 'none';
    }

    // Llamar a la función al cargar la página para manejar el valor predeterminado
    updateFieldVisibility();

    // Detectar cambios en el campo select
    cargoField.addEventListener('change', updateFieldVisibility);
});
