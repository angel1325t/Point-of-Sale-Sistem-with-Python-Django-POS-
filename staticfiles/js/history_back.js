document.addEventListener("DOMContentLoaded", function() {
    const goBackButton = document.querySelector("#goBackButton");
    if (goBackButton) {
        goBackButton.addEventListener("click", function(event) {
            event.preventDefault();
            if (document.referrer) {
                window.location.href = document.referrer;
            } else {
                window.history.back();
            }
        });
    }
});
