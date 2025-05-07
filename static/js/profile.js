// Selección de elementos
const editBtn = document.getElementById('edit-profile-btn');
const cancelBtn = document.getElementById('cancel-edit-btn');
const editForm = document.getElementById('edit-form');
const profilePictureInput = document.getElementById('profile_picture');
const profilePreview = document.getElementById('profile_preview');

// Mostrar formulario de edición
editBtn.addEventListener('click', () => {
    editForm.classList.remove('opacity-0', 'max-h-0');
    editForm.classList.add('max-h-96', 'opacity-100');
});

// Cancelar edición
cancelBtn.addEventListener('click', () => {
    editForm.classList.remove('max-h-96', 'opacity-100');
    editForm.classList.add('opacity-0', 'max-h-0');
    document.getElementById('username-input').value = empleadoUsername;
    document.getElementById('email-input').value = empleadoEmail;
});

// Manejar cambio de imagen con fetch
profilePictureInput.addEventListener('change', function() {
    const file = this.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            profilePreview.src = e.target.result;
        };
        reader.readAsDataURL(file);

        const formData = new FormData();
        formData.append('profile_image', file);
        formData.append('csrfmiddlewaretoken', csrfToken);

        fetch(updateProfilePictureUrl, {
            method: 'POST',
            body: formData,
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                profilePreview.src = data.image_url;
            } else {
                alert('Error al subir la imagen: ' + data.error);
                profilePreview.src = defaultProfileUrl;
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al subir la imagen');
            profilePreview.src = defaultProfileUrl;
        });
    }
});

// Fondo ondulado según el día
const backgrounds = [ /*... tu lista de URLs ...*/ ];

const today = new Date().getDay();
document.querySelector('.bg-wave').style.backgroundImage = backgrounds[today];
