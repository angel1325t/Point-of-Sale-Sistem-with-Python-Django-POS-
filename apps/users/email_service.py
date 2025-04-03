import logging
from django.core.mail import send_mail
from django.core.mail import BadHeaderError
from smtplib import SMTPException

logger = logging.getLogger(__name__)

class EmailService:
    def __init__(self, id, user, password=None):
        self.id = id  # Guardamos el ID del usuario o token
        self.user = user
        self.password = password
        self.subject = "Tus credenciales de acceso"
        self.html_content = self.generate_html_content()

    def generate_html_content(self):
        """Genera el HTML para el email de bienvenida/registro"""
        return f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Bienvenida</title>
        </head>
        <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
            <table align="center" width="100%" style="max-width: 600px; background-color: white; padding: 20px; border-radius: 5px; 
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);">
                <tr>
                    <td>
                        <h2 style="color: #2234B9; text-align: center;">Bienvenido, {self.user.username}!</h2>
                        <p>Hola {self.user.username},</p>
                        <p>Te hemos registrado en PuntoXpress. Para completar tu registro y asegurarte de que tu cuenta está segura, por favor establece una nueva contraseña.</p>
                        
                        <p style="text-align: center; margin-top: 20px;">
                            <a href="http://127.0.0.1:8000/email/{self.id}" style="background-color: #2234B9; color: white; padding: 12px 25px; text-decoration: none; 
                            border-radius: 5px; display: inline-block; font-size: 16px; font-weight: bold;">Establecer Nuevas Credenciales</a>
                        </p>

                        <p style="margin-top: 20px; background-color: #FFDD57; padding: 10px; border-radius: 5px; color: #9A7D0A; 
                        font-weight: bold; text-align: center;">
                            ¡Es necesario que cambies tus credenciales inmediatamente! No puedes acceder a tu cuenta hasta que lo hagas.
                        </p>
                        <p><strong>Usuario por defecto:</strong> {self.user.username}</p>
                    </td>
                </tr>
            </table>
        </body>
        </html>
        """

    def generate_verification_html(self, verification_url):
        """Genera el HTML para el email de verificación"""
        return f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Verificación de Email</title>
        </head>
        <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
            <table align="center" width="100%" style="max-width: 600px; background-color: white; padding: 20px; border-radius: 5px; 
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);">
                <tr>
                    <td>
                        <h2 style="color: #2234B9; text-align: center;">Verifica tu nuevo email</h2>
                        <p>Hola {self.user.username},</p>
                        <p>Has solicitado cambiar tu email en PuntoXpress. Por favor verifica tu nueva dirección de correo electrónico haciendo clic en el botón de abajo:</p>
                        
                        <p style="text-align: center; margin-top: 20px;">
                            <a href="{verification_url}" style="background-color: #2234B9; color: white; padding: 12px 25px; text-decoration: none; 
                            border-radius: 5px; display: inline-block; font-size: 16px; font-weight: bold;">Verificar Email</a>
                        </p>

                        <p style="margin-top: 20px; color: #666;">
                            Si no has solicitado este cambio, por favor ignora este mensaje.
                        </p>
                    </td>
                </tr>
            </table>
        </body>
        </html>
        """

    def send_email(self):
        try:
            send_mail(
                self.subject,
                "",
                'angelalexanderperezmartinez47@gmail.com',
                [self.user.email],
                html_message=self.html_content
            )
            logger.info(f"Correo enviado correctamente a {self.user.email}")

        except BadHeaderError:
            logger.error("Error: Cabecera inválida en el correo.")
        except SMTPException as e:
            logger.error(f"Error SMTP: {e}")
        except Exception as e:
            logger.error(f"Error general al enviar el correo: {e}")