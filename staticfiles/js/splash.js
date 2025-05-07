document.addEventListener('DOMContentLoaded', function() {
    setTimeout(function() {
        const splashScreen = document.getElementById('splash-screen');
        splashScreen.classList.add('splash-hide');
        
        // Redirect or show main content after splash screen
        setTimeout(function() {
            window.location.href = '/login'; // Change this to your main page URL
        }, 500);
    }, 2500); // Splash screen shows for 3.5 seconds to let animations run
});