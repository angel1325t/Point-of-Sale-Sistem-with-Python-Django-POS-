from django.db import IntegrityError
from .email_validator import EmailValidator
from .email_service import EmailService
import uuid
from django.contrib.auth import logout, login, authenticate
from django.contrib.auth import get_user_model
from django.views.decorators.csrf import csrf_protect
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponseForbidden, HttpResponse
from django.contrib import messages
from django.utils.timezone import localtime, now
from django.contrib.auth.hashers import make_password
from django.views import View
import os
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.contrib.auth import get_user_model
from django.views.decorators.http import require_POST
import os
from django.conf import settings
from django.utils import timezone
from .models import EmailVerificationToken
from django.core.exceptions import ValidationError


User = get_user_model()

CustomUser = get_user_model()
@csrf_protect
def login_view(request):
    if request.user.is_authenticated:
        if request.user.is_superuser or request.user.groups.filter(name="Gerente").exists():
            return redirect("admin:index")
        if request.user.groups.filter(name="Vendedor").exists():
            return redirect("ventas")
        if request.user.groups.filter(name="Almacén").exists():
            return redirect("products")
        return redirect("technical_problem")

    if request.method == "POST":
        login_input = request.POST.get("login_input")  # Renamed to be more generic
        password = request.POST.get("password")

        if not login_input:
            messages.error(request, "El nombre de usuario o email es obligatorio.")
            return redirect("login")

        if not password:
            messages.error(request, "La contraseña es obligatoria.")
            return redirect("login")

        # Verificar si el usuario existe antes de autenticar
        User = get_user_model()
        user = None
        
        # Primero intenta buscar por email, luego por username
        try:
            # Intenta buscar por email
            user = User.objects.get(email=login_input)
        except User.DoesNotExist:
            try:
                # Si no encuentra por email, busca por username
                user = User.objects.get(username=login_input)
            except User.DoesNotExist:
                user = None

        # Verificar si el usuario está activo
        if user and not user.is_active:
            return redirect("disabled_user")

        # Intentar autenticar solo si el usuario existe
        if user:
            # Usar el username del usuario encontrado para la autenticación
            user = authenticate(request, username=user.username, password=password)

        if user is not None:
            login(request, user)

            if user.is_superuser or user.groups.filter(name="Gerente").exists():
                return redirect("admin:index")
            if user.groups.filter(name="Vendedor").exists():
                return redirect("ventas")
            if user.groups.filter(name="Almacén").exists():
                return redirect("products")

            return redirect("technical_problem")

        messages.error(request, "Nombre de usuario/email o contraseña incorrectos.")
        return redirect("login")

    return render(request, "registration/login.html")

def disabled_user_view(request):
    return render(request, "registration/disable_user.html")

def technical_problem_view(request):
    return render(request, "registration/technical_problem.html")


# Mantener como FBV porque solo cierra sesión y redirige
def logout_view(request):
    logout(request)
    return redirect("/login")


# Convertir en CBV porque maneja múltiples métodos HTTP y actualización de datos
class CreateCredentialsView(View):
    def get(self, request, id):
        user = get_object_or_404(CustomUser, id=id)

        # Si last_login no es NULL, devolver error 403
        if user.last_login is not None:
            return HttpResponseForbidden(
                "No tienes permiso para acceder a esta página."
            )

        return render(
            request,
            "registration/create_credentials.html",
            {"user": user, "profile_image": user.profile_image},
        )

    def post(self, request, id):
        user = get_object_or_404(CustomUser, id=id)

        # Si last_login no es NULL, devolver error 403
        if user.last_login is not None:
            return HttpResponseForbidden("No tienes permiso para realizar esta acción.")

        username = request.POST.get("username")
        password = request.POST.get("password")
        profile_image = request.FILES.get("profile_image")

        if username:
            user.username = username

        if password:
            user.password = make_password(password)

        if profile_image:
            ext = os.path.splitext(profile_image.name)[1]
            filename = f"user_{user.id}{ext}"

            if user.profile_image:
                old_path = user.profile_image.path
                if os.path.exists(old_path):
                    os.remove(old_path)

            user.profile_image.save(filename, profile_image)

        user.save()

        # Agregar mensaje de éxito y redirigir al login
        messages.success(
            request,
            "Credenciales creadas exitosamente. Ahora puedes iniciar sesión en tu cuenta.",
        )
        return redirect("login")
    
def splash(request):
    return render(request, "splash.html")



@login_required
def profile(request):
    empleado = request.user
    last_login_local = timezone.localtime(empleado.last_login) if empleado.last_login else None
    hoy = timezone.now().date()

    if last_login_local:
        if last_login_local.date() == hoy:
            fecha_mostrada = f"Hoy, {last_login_local.strftime('%I:%M %p')}"
        else:
            fecha_mostrada = last_login_local.strftime('%d/%m/%Y, %I:%M %p')
    else:
        fecha_mostrada = "Nunca"

    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        original_email = empleado.email
        error = None
        success = None

        try:
            # Verificar si el email cambió
            email_changed = email != original_email

            if email_changed:
                # Validar el email con Hunter.io
                email_validator = EmailValidator(email)
                email_validator.validate()  # Esto lanzará ValidationError si no es válido

                # Crear un token de verificación
                verification_token = EmailVerificationToken.objects.create(
                    user=empleado,
                    new_email=email
                )

                verification_url = f"http://{request.get_host()}/verify-email/{verification_token.token}"
                
                # Enviar email de verificación
                email_service = EmailService(
                    id=str(verification_token.token),
                    user=empleado,
                    password=None
                )
                email_service.subject = "Verifica tu nuevo email"
                email_service.html_content = email_service.generate_verification_html(verification_url)
                email_service.send_email()

                success = "Se ha enviado un email de verificación a tu nueva dirección. Por favor, verifica tu email."

            # Actualizar el username
            empleado.username = username
            empleado.save()

            context = {
                "empleado": empleado,
                "fecha_mostrada": fecha_mostrada,
                "success": success
            }
            return render(request, 'test/confirm_email_change.html', context)

        except IntegrityError:
            error = "Este email ya está en uso por otro usuario."
        except ValidationError as e:
            error = str(e)
        except Exception as e:
            error = f"Error al actualizar el perfil: {str(e)}"

        if error:
            context = {
                "empleado": empleado,
                "fecha_mostrada": fecha_mostrada,
                "error": error
            }
            return render(request, 'test/confirm_email_change.html', context)

    context = {
        "empleado": empleado,
        "fecha_mostrada": fecha_mostrada,
    }
    return render(request, 'test/edit_profile.html', context)

@login_required
def verify_email(request, token):
    try:
        verification_token = EmailVerificationToken.objects.get(token=token, user=request.user, is_verified=False)
        
        # Verificar si el email ya está en uso por otro usuario
        if User.objects.exclude(pk=request.user.pk).filter(email=verification_token.new_email).exists():
            return render(request, 'test/confirm_email_change.html', {
                "empleado": request.user,
                "fecha_mostrada": "Nunca",
                "error": "Este correo ya está en uso por otro usuario."
            })

        request.user.email = verification_token.new_email
        request.user.save()
        verification_token.is_verified = True
        verification_token.save()
        return render(request, 'test/confirm_email_change.html', {
            "empleado": request.user,
            "fecha_mostrada": "Nunca",
            "success": "Email verificado correctamente."
        })
    except EmailVerificationToken.DoesNotExist:
        return render(request, 'test/confirm_email_change.html', {
            "empleado": request.user,
            "fecha_mostrada": "Nunca",
            "error": "Token de verificación inválido o ya utilizado."
        })

@login_required
@require_POST
def update_profile_picture(request):
    """Vista para actualizar la imagen de perfil usando AJAX"""
    try:
        if 'profile_image' not in request.FILES:
            return JsonResponse({'error': 'No se proporcionó ninguna imagen'}, status=400)
        
        user = request.user
        image = request.FILES['profile_image']
        
        # Eliminar la imagen anterior si existe
        if user.profile_image and os.path.isfile(os.path.join(settings.MEDIA_ROOT, user.profile_image.name)):
            os.remove(os.path.join(settings.MEDIA_ROOT, user.profile_image.name))
        
        # Guardar la nueva imagen
        user.profile_image = image
        user.save()
        
        return JsonResponse({
            'success': True,
            'image_url': user.profile_image.url
        })
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)