document.addEventListener("DOMContentLoaded", function () {
    let isSuperuserCheckbox = document.getElementById("id_is_superuser");
    let cargoField = document.getElementById("id_cargo");
    let cargoLabel = document.querySelector("label[for='id_cargo']"); // Selecciona el label

    if (!isSuperuserCheckbox || !cargoField || !cargoLabel) {
        console.error("Uno de los elementos no se encontró en el DOM.");
        return;
    }

    function toggleCargoField() {
        let cargoWrapper = cargoField.closest(".form-row") || cargoField.closest(".field-cargo");
        
        if (isSuperuserCheckbox.checked) {
            cargoWrapper.style.display = "none";  // Oculta el campo
            cargoLabel.style.display = "none";  // Oculta el label
            cargoField.value = "admin";  // Asigna automáticamente "admin"
        } else {
            cargoWrapper.style.display = "";  // Muestra el campo
            cargoLabel.style.display = "";  // Muestra el label
        }

        console.log("Superuser checked:", isSuperuserCheckbox.checked);
    }

    isSuperuserCheckbox.addEventListener("change", toggleCargoField);
    toggleCargoField(); // Aplica el estado inicial al cargar la página
});
