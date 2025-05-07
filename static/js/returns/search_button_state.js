// search_button_state.js
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const searchButton = document.getElementById('search-button');
  
    // Función para actualizar el estado del botón
    function updateButtonState() {
      if (searchInput.value.trim() === '') {
        searchButton.disabled = true;
        searchButton.classList.remove('bg-blue-700', 'hover:bg-blue-800');
        searchButton.classList.add('bg-blue-400', 'cursor-not-allowed');
      } else {
        searchButton.disabled = false;
        searchButton.classList.remove('bg-blue-400', 'cursor-not-allowed');
        searchButton.classList.add('bg-blue-700', 'hover:bg-blue-800');
      }
    }
  
    // Ejecutar al cargar la página
    updateButtonState();
  
    // Escuchar cambios en el input
    searchInput.addEventListener('input', updateButtonState);
  });
  