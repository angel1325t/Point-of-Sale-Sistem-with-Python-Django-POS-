document.querySelectorAll('input[name="profile_image"]').forEach(input => {
    input.addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                // Buscar la imagen dentro del mismo contenedor del input
                const imgPreview = input.closest('label').querySelector("img[id^='profile_preview']");
                if (imgPreview) {
                    imgPreview.src = e.target.result;
                }
            };
            reader.readAsDataURL(file);
        }
    });
});