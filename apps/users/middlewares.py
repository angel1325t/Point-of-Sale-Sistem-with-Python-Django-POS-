import logging
from django.shortcuts import render
from django.http import HttpResponseForbidden, HttpResponseNotFound, HttpResponseServerError

logger = logging.getLogger(__name__)

class ErrorLoggingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        # Procesa la solicitud
        response = self.get_response(request)

        # Si el código de estado es 500 (error interno del servidor)
        if response.status_code == 500:
            logger.error(f"Error 500 en {request.path}")
            # Renderiza un template para error 500
            return render(request, 'errors/500.html', status=500)

        # Si el código de estado es 404 (no encontrado)
        elif response.status_code == 404:
            logger.warning(f"Error 404 en {request.path}")
            # Renderiza un template para error 404
            return render(request, 'errors/404.html', status=404)

        # Si el código de estado es 403 (prohibido)
        elif response.status_code == 403:
            logger.warning(f"Error 403 en {request.path}")
            # Renderiza un template para error 403
            return render(request, 'errors/403.html', status=403)

        # Si no es un error, simplemente retorna la respuesta original
        return response
