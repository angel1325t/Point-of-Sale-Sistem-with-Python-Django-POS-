document.addEventListener("DOMContentLoaded", function () {
    // Esperar un poco después de la carga completa del DOM para asegurarse de que Select2 ya se aplicó
    setTimeout(function () {
        let selectElement = document.querySelector('.select2-hidden-accessible');
        
        if (selectElement) {
            selectElement.classList.remove('select2-hidden-accessible'); // Remover la clase oculta
            selectElement.style.display = "block"; // Asegurar que el select sea visible
        }

        // Opcional: Ocultar el span de Select2
        let select2Container = document.querySelector('.select2');
        if (select2Container) {
            select2Container.style.display = "none"; // Esconder el span que Select2 genera
        }
    }, 500); // Espera 500ms para asegurarse de que Select2 ya está cargado
});
