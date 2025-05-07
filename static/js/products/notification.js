
let socket;
let notificationQueue = [];
let isProcessingQueue = false;

// Configure Notyf
const notyf = new Notyf({
    duration: 3500,
    position: {
        x: 'right',
        y: 'top'
    },
    types: [
        {
            type: 'success',
            background: '#18253a',
            icon: false
        },
        {
            type: 'error',
            background: '#18253a',
            icon: false
        }
    ]
});

// Process notifications one by one
function processNotificationQueue() {
    if (notificationQueue.length === 0) {
        isProcessingQueue = false;
        return;
    }

    isProcessingQueue = true;
    const notification = notificationQueue.shift();

    if (notification.type === 'success') {
        notyf.success(notification.message);
    } else {
        notyf.error(notification.message);
    }

    // Wait for the current notification to finish before showing the next one
    // Adding a small additional delay between notifications
    setTimeout(() => {
        processNotificationQueue();
    }, 3800); // 3500ms (notyf duration) + 300ms extra gap
}

// Add notification to queue and process if not already processing
function addToNotificationQueue(message, type = 'success') {
    notificationQueue.push({
        message: message,
        type: type
    });

    if (!isProcessingQueue) {
        processNotificationQueue();
    }
}

function connectWebSocket() {
    socket = new WebSocket("ws://127.0.0.1:8000/ws/stock/");

    socket.onopen = function (event) {
        console.log("WebSocket conectado");
    };

    socket.onmessage = function (event) {
        console.log("Datos recibidos:", event.data);
        try {
            const data = JSON.parse(event.data);
            addToNotificationQueue(data.message, 'success');
        } catch (error) {
            console.error("Error al parsear mensaje:", error);
            addToNotificationQueue("Error al procesar el mensaje", 'error');
        }
    };

    socket.onerror = function (error) {
        console.error("Error en WebSocket:", error);
        addToNotificationQueue("Error de conexión", 'error');
    };

    socket.onclose = function (event) {
        console.log("WebSocket cerrado:", event);
        setTimeout(connectWebSocket, 3000);
    };
}

document.addEventListener("DOMContentLoaded", function () {
    connectWebSocket();

    // Test function to simulate multiple notifications (can be removed in production)
    window.testNotifications = function (count) {
        for (let i = 1; i <= count; i++) {
            addToNotificationQueue(`Test notification ${i} of ${count}`);
        }
    };
});
