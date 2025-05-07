document.addEventListener('DOMContentLoaded', function () {
    const cargoField = document.getElementById('id_cargo');
    const firstNameField = document.getElementById('id_first_name');
    const lastNameField = document.getElementById('id_last_name');
    const firstNameRow = firstNameField.closest('.row');
    const lastNameRow = lastNameField.closest('.row');
    const firstNameLabel = document.querySelector("label[for='id_first_name']");
    const lastNameLabel = document.querySelector("label[for='id_last_name']");

    // Función para actualizar la visibilidad de los campos
    function updateFieldVisibility() {
        const isVendedor = cargoField.value === 'vendedor';
        const displayStyle = isVendedor ? 'block' : 'none';
        const labelStyle = isVendedor ? '' : 'none';
        const rowStyle = isVendedor ? 'flex' : 'none';

        // Aplicar estilos según el valor de "cargo"
        firstNameField.style.display = displayStyle;
        lastNameField.style.display = displayStyle;
        firstNameLabel.style.display = labelStyle;
        lastNameLabel.style.display = labelStyle;
        firstNameRow.style.display = rowStyle;
        lastNameRow.style.display = rowStyle;
    }

    // Llamar a la función al cargar la página para manejar el valor predeterminado
    updateFieldVisibility();

    // Detectar cambios en el campo select
    cargoField.addEventListener('change', updateFieldVisibility);
});
