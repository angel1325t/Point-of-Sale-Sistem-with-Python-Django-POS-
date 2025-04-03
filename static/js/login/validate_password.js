document.addEventListener('DOMContentLoaded', function () {
    const newPasswordField = document.getElementById('id_new_password1');
    const updateButton = document.getElementById('updateButton');
    const strengthText = document.getElementById('password-strength');
    const strengthFill = document.getElementById('strength-fill');
    const passwordField = document.getElementById('password');
    const togglePassword = document.getElementById('togglePassword');

    if (newPasswordField) {
        newPasswordField.setAttribute('id', 'password');
        newPasswordField.addEventListener('input', validatePassword);
    }

    function validatePassword() {
        let password = document.getElementById("password").value;
        let strength = 0;
        let messages = [];

        if (password.length >= 8) {
            strength++;
        } else {
            messages.push("Debe tener al menos 8 caracteres");
        }
        if (/[A-Z]/.test(password)) {
            strength++;
        } else {
            messages.push("Debe incluir al menos una letra mayúscula");
        }
        if (/[0-9]/.test(password)) {
            strength++;
        } else {
            messages.push("Debe incluir al menos un número");
        }
        if (/[^A-Za-z0-9]/.test(password)) {
            strength++;
        } else {
            messages.push("Debe incluir al menos un carácter especial (@, #, $, etc.)");
        }

        // Calcular el porcentaje de la fuerza de la contraseña
        let strengthPercentage = (strength / 4) * 100;
        strengthFill.style.width = strengthPercentage + "%";

        // Eliminar clases previas
        strengthFill.classList.remove("bg-red-500", "bg-orange-500", "bg-yellow-500", "bg-green-500");

        // Cambiar el color de la barra según el porcentaje
        if (strengthPercentage >= 75) {
            strengthFill.classList.add("bg-green-500"); // 75% o más
        } else if (strengthPercentage >= 50) {
            strengthFill.classList.add("bg-yellow-500"); // 50% - 74%
        } else if (strengthPercentage >= 25) {
            strengthFill.classList.add("bg-orange-500"); // 25% - 49%
        } else {
            strengthFill.classList.add("bg-red-500"); // Menos del 25%
        }

        // Mostrar mensaje con los requisitos faltantes
        if (messages.length > 0) {
            strengthText.innerHTML = messages.join('<br>'); // Usar <br> para saltos de línea en HTML
            strengthText.className = "mt-2 text-red-500 text-sm";
        } else {
            strengthText.textContent = "Contraseña segura";
            strengthText.className = "mt-2 text-green-500 text-sm";
        }

        // Activar o desactivar el botón de actualización
        if (strengthPercentage >= 75) {
            updateButton.removeAttribute('disabled');
            updateButton.style.cursor = 'pointer';
        } else {
            updateButton.setAttribute('disabled', true);
            updateButton.style.cursor = 'not-allowed';
        }
    }

    togglePassword.addEventListener('click', function () {
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
        this.innerHTML = type === 'password' ? '<img src="/static/icons/eye.svg" alt="">' : '<img src="/static/icons/eye-slash.svg" alt="">';
    });
});