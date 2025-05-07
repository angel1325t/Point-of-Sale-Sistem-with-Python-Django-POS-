document.addEventListener('DOMContentLoaded', function () {
    const filterToggle = document.querySelector('.filter-toggle');
    const filtersContainer = document.querySelector('.filters-container');
    const toggleIcon = document.querySelector('.toggle-icon');
    
    if (filterToggle && filtersContainer && toggleIcon) {
      // Add initial styling for the filters container
      filtersContainer.style.maxHeight = "0";
      filtersContainer.style.transition = "max-height 0.4s ease-in-out";
      
      filterToggle.addEventListener('click', function () {
        // Toggle the hidden class
        const isHidden = filtersContainer.classList.contains('hidden');
        
        if (isHidden) {
          // Show the filters container first
          filtersContainer.classList.remove('hidden');
          
          // Set initial styles before transition
          filtersContainer.style.maxHeight = "0";
          
          // Force reflow to ensure transitions work
          void filtersContainer.offsetWidth;
          
          // Trigger transitions
          filtersContainer.style.maxHeight = "500px"; // Set a max value that covers your content
        } else {
          // Hide with transitions
          filtersContainer.style.maxHeight = "0";
          
          // Add a delay before adding the hidden class
          setTimeout(() => {
            filtersContainer.classList.add('hidden');
          }, 400); // Match with transition duration
        }
        
        // Toggle icon rotation with smooth transition
        toggleIcon.style.transition = "transform 0.3s ease";
        toggleIcon.style.transform = isHidden ? "rotate(180deg)" : "rotate(0)";
      });
    }
  });