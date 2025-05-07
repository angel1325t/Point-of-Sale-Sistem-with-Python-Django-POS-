document.addEventListener('DOMContentLoaded', () => {
    const chatButton = document.getElementById('chatButton');
    const chatContainer = document.getElementById('chatContainer');
    const chatMessages = document.getElementById('chatMessages');
    const chatInput = document.getElementById('chatInput');
    const closeChat = document.getElementById('closeChat');
    const minimizeChat = document.getElementById('minimizeChat');
    const minimizeIcon = document.getElementById('minimizeIcon');
    let isMinimized = false;

    // Toggle chat open/close
    chatButton.addEventListener('click', () => {
        const isChatHidden = chatContainer.classList.contains('hidden');
        
        chatContainer.classList.toggle('hidden');
        
        if (isChatHidden) {
            // Resetear estado de minimizado al abrir
            if (isMinimized) {
                toggleMinimize(false);
            }
            
            // Enfocar campo de entrada al abrir
            setTimeout(() => {
                chatInput.focus();
            }, 100);
        }
    });

    // Close chat
    closeChat.addEventListener('click', () => {
        chatContainer.classList.add('hidden');
    });

    // Function to toggle minimize state
    function toggleMinimize(state = null) {
        isMinimized = state !== null ? state : !isMinimized;
        
        if (isMinimized) {
            // Minimizar
            chatMessages.classList.add('hidden', 'h-0');
            chatMessages.classList.remove('flex-1', 'min-h-[200px]', 'sm:min-h-[300px]');
            
            // Cambiar ícono a expandir
            minimizeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>';
        } else {
            // Maximizar
            chatMessages.classList.remove('hidden', 'h-0');
            chatMessages.classList.add('flex-1', 'min-h-[200px]', 'sm:min-h-[300px]');
            
            // Cambiar ícono a minimizar
            minimizeIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>';
            
            // Scroll al final
            setTimeout(() => {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }, 100);
        }
    }

    // Minimize chat
    minimizeChat.addEventListener('click', () => {
        toggleMinimize();
    });

    window.sendMessage = async () => {
        const message = chatInput.value.trim();
        if (!message) return;

        // Si está minimizado, maximizar primero
        if (isMinimized) {
            toggleMinimize(false);
        }

        // Add user message to chat
        const userMessage = document.createElement('div');
        userMessage.className = 'flex justify-end mb-2 sm:mb-3';
        userMessage.innerHTML = `
            <div class="max-w-[75%] sm:max-w-[80%]">
                <p class="px-3 py-2 text-xs text-white break-words bg-blue-800 rounded-t-lg rounded-bl-lg sm:text-sm">${message}</p>
            </div>
        `;
        chatMessages.appendChild(userMessage);
        chatInput.value = '';

        // Show loading indicator
        const loadingMessage = document.createElement('div');
        loadingMessage.className = 'flex justify-start mb-2 sm:mb-3';
        loadingMessage.id = 'loadingMessage';
        loadingMessage.innerHTML = `
            <div class="max-w-[75%] sm:max-w-[80%]">
                <div class="flex items-center px-3 py-2 text-xs text-gray-700 bg-gray-200 rounded-t-lg rounded-br-lg sm:text-sm">
                    <div class="flex space-x-1">
                        <div class="w-1.5 h-1.5 sm:w-2 sm:h-2 bg-gray-500 rounded-full animate-bounce" style="animation-delay: 0s"></div>
                        <div class="w-1.5 h-1.5 sm:w-2 sm:h-2 bg-gray-500 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
                        <div class="w-1.5 h-1.5 sm:w-2 sm:h-2 bg-gray-500 rounded-full animate-bounce" style="animation-delay: 0.4s"></div>
                    </div>
                </div>
            </div>
        `;
        chatMessages.appendChild(loadingMessage);

        // Scroll to bottom
        chatMessages.scrollTop = chatMessages.scrollHeight;

        try {
            const response = await fetch('/chat/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': getCookie('csrftoken'),
                },
                body: JSON.stringify({ message }),
            });

            const data = await response.json();
            
            // Remove loading indicator
            const loadingIndicator = document.getElementById('loadingMessage');
            if (loadingIndicator) {
                loadingIndicator.remove();
            }

            // Add AI response
            const aiMessage = document.createElement('div');
            aiMessage.className = 'flex justify-start mb-2 sm:mb-3';
            aiMessage.innerHTML = `
                <div class="max-w-[75%] sm:max-w-[80%]">
                    <p class="px-3 py-2 text-xs text-gray-700 break-words bg-gray-200 rounded-t-lg rounded-br-lg sm:text-sm">${data.response}</p>
                </div>
            `;
            chatMessages.appendChild(aiMessage);

            // Scroll to bottom
            chatMessages.scrollTop = chatMessages.scrollHeight;
        } catch (error) {
            console.error('Error:', error);
            
            // Remove loading indicator
            const loadingIndicator = document.getElementById('loadingMessage');
            if (loadingIndicator) {
                loadingIndicator.remove();
            }
            
            // Show error message
            const errorMessage = document.createElement('div');
            errorMessage.className = 'flex justify-start mb-2 sm:mb-3';
            errorMessage.innerHTML = `
                <div class="max-w-[75%] sm:max-w-[80%]">
                    <p class="px-3 py-2 text-xs text-white break-words bg-red-500 rounded-t-lg rounded-br-lg sm:text-sm">Lo sentimos, hubo un error al procesar tu mensaje.</p>
                </div>
            `;
            chatMessages.appendChild(errorMessage);
        }

        // Focus on input
        chatInput.focus();
    };

    // Get CSRF token
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
    
    // Handle document click to close chat when clicking outside
    document.addEventListener('click', (event) => {
        if (!chatContainer.classList.contains('hidden') && 
            !chatContainer.contains(event.target) && 
            event.target !== chatButton && 
            !chatButton.contains(event.target)) {
            chatContainer.classList.add('hidden');
        }
    });
    
    // Stop propagation for chat container clicks
    chatContainer.addEventListener('click', (event) => {
        event.stopPropagation();
    });
});