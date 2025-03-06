function showLoader() {
    document.getElementById('loading-spinner').style.display = 'flex';
    document.body.classList.add('disable-interaction'); // Bloquea interacciones
}

function hideLoader() {
    setTimeout(() => {
        document.getElementById('loading-spinner').style.display = 'none';
        document.body.classList.remove('disable-interaction'); // Restaura interacciones
    }, 500);
}

// Ocultar el loader solo si la página se ha cargado completamente
window.addEventListener("load", function () {
    setTimeout(hideLoader, 1000); // Agregar un pequeño retraso para evitar que se oculte demasiado rápido
});

// Mostrar el loader al enviar formularios
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', function () {
        showLoader();
    });
}); 
