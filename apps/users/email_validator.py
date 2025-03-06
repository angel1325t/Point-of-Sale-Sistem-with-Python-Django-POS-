# my_app/email_validator.py
import requests
from django.core.exceptions import ValidationError
from django.conf import settings

class EmailValidator:
    def __init__(self, email):
        self.email = email
        self.api_url = "https://api.hunter.io/v2/email-verifier"
        self.api_key = settings.HUNTER_API_KEY

    # la funcion esta comentada por ahora para no gastar las validaciones gratis de email
    def validate(self):
    #     # Hacer la solicitud a la API de Hunter.io
    #     response = requests.get(self.api_url, params={
    #         'email': self.email,
    #         'api_key': self.api_key
    #     })

    #     if response.status_code == 200:
    #         data = response.json()
            
    #         # Verificar si el correo es válido
    #         if data['data']['result'] == 'deliverable':
    #             return True
    #         else:
    #             raise ValidationError(f"El correo electrónico {self.email} no es válido.")
    #     else:
    #         raise ValidationError("Hubo un error al verificar el correo electrónico. Intenta nuevamente más tarde.")
        return True
