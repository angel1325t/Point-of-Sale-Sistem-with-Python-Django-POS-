import logging
from django.core.mail import send_mail
from django.core.mail import BadHeaderError
from django.template.loader import render_to_string
from smtplib import SMTPException

logger = logging.getLogger(__name__)

class EmailService:
    def __init__(self, id, user, password=None):
        self.id = id  # Guardamos el ID del usuario o token
        self.user = user
        self.password = password
        self.subject = "Tus credenciales de acceso"

    def generate_html_content(self):
        """Genera el HTML para el email de bienvenida/registro usando un template"""
        context = {
            'username': self.user.username,
            'id': self.id
        }
        return render_to_string('emails/welcome_email.html', context)

    def generate_verification_html(self, verification_url):
        """Genera el HTML para el email de verificación usando un template"""
        context = {
            'username': self.user.username,
            'verification_url': verification_url
        }
        return render_to_string('emails/verification_email.html', context)

    def send_email(self, recipient_email=None, subject=None, html_content=None):
        """Envía un correo electrónico, permitiendo personalizar el destinatario, asunto y contenido HTML"""
        recipient = recipient_email if recipient_email else self.user.email
        subject = subject if subject else self.subject
        html_content = html_content if html_content else self.generate_html_content()

        try:
            send_mail(
                subject,
                "",
                'angelalexanderperezmartinez47@gmail.com',
                [recipient],
                html_message=html_content
            )
            logger.info(f"Correo enviado correctamente a {recipient}")
        except BadHeaderError:
            logger.error("Error: Cabecera inválida en el correo.")
        except SMTPException as e:
            logger.error(f"Error SMTP: {e}")
        except Exception as e:
            logger.error(f"Error general al enviar el correo: {e}")