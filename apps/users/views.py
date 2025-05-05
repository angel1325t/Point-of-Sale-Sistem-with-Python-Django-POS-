from django.db import IntegrityError
from .email_validator import EmailValidator
from .email_service import EmailService
from django.contrib.auth import logout, login, authenticate
from django.views.decorators.csrf import csrf_protect
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponseForbidden
from django.contrib import messages
from django.contrib.auth.hashers import make_password
from django.views import View
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.contrib.auth import get_user_model
from django.views.decorators.http import require_POST
import os
from django.conf import settings
from django.utils import timezone
from .models import EmailVerificationToken
from django.core.exceptions import ValidationError

CustomUser = get_user_model()

@csrf_protect
def login_view(request):
    if request.user.is_authenticated:
        # Check for unverified email verification token
        verification_token = EmailVerificationToken.objects.filter(
            user=request.user, 
            is_verified=False
        ).order_by('-created_at').first()  # Get the most recent token
        if verification_token:
            # Redirect to email verification with the token
            return redirect('verify_email', token=verification_token.token)
        # No pending email verification, proceed with normal redirection
        if request.user.is_superuser or request.user.groups.filter(name="Gerente").exists():
            return redirect("admin:index")
        if request.user.groups.filter(name="Vendedor").exists():
            return redirect("ventas")
        if request.user.groups.filter(name="Almacén").exists():
            return redirect("products")
        # Log out the user before redirecting to technical_problem
        logout(request)
        return redirect("technical_problem")

    if request.method == "POST":
        login_input = request.POST.get("login_input")
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
            user = User.objects.get(email=login_input)
        except User.DoesNotExist:
            try:
                user = User.objects.get(username=login_input)
            except User.DoesNotExist:
                user = None

        # Verificar si el usuario está activo
        if user and not user.is_active:
            return redirect("disabled_user")

        # Intentar autenticar solo si el usuario existe
        if user:
            user = authenticate(request, username=user.username, password=password)

        if user is not None:
            # Log the user in
            login(request, user)
            # Check for unverified email verification token
            verification_token = EmailVerificationToken.objects.filter(
                user=user, 
                is_verified=False
            ).order_by('-created_at').first()  # Get the most recent token
            if verification_token:
                # Redirect to email verification with the token
                return redirect('verify_email', token=verification_token.token)
            # No pending email verification, proceed with normal redirection
            if user.is_superuser or user.groups.filter(name="Gerente").exists():
                return redirect("admin:index")
            if user.groups.filter(name="Vendedor").exists():
                return redirect("ventas")
            if user.groups.filter(name="Almacén").exists():
                return redirect("products")
            messages.error(request, "No tienes permisos para acceder a este sistema.")
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
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.shortcuts import render
from django.db import IntegrityError
from django.utils import timezone
from .models import EmailVerificationToken
from .email_service import EmailService
from .email_validator import EmailValidator  # Asegúrate de que esto esté importado

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

                verification_url = f"http://{request.get_host()}/verificar-email/{verification_token.token}"
                
                # Enviar email de verificación
                email_service = EmailService(
                    id=str(verification_token.token),
                    user=empleado,
                    password=None
                )
                email_service.subject = "Verifica tu nuevo email"
                email_service.html_content = email_service.generate_verification_html(verification_url)
                email_service.send_email(
                    recipient_email=email,  # Enviar al nuevo email
                    subject="Verifica tu nuevo email",
                    html_content=email_service.html_content
                )

                messages.success(request, "Se ha enviado un email de verificación a tu nueva dirección. Por favor, verifica tu email.")
                # Update username even if email changed
                empleado.username = username
                empleado.save()
                context = {
                    "empleado": empleado,
                    "fecha_mostrada": fecha_mostrada,
                }
                return render(request, 'empleados/edit_profile.html', context)

            # If only username changed or no changes
            if username != empleado.username:
                empleado.username = username
                empleado.save()
                messages.success(request, "¡Tu nombre de usuario ha sido actualizado exitosamente!")
            else:
                messages.info(request, "No se realizaron cambios en el perfil.")

            context = {
                "empleado": empleado,
                "fecha_mostrada": fecha_mostrada,
            }
            return render(request, 'empleados/edit_profile.html', context)

        except IntegrityError:
            messages.error(request, "Este email ya está en uso por otro usuario.")
        except ValidationError as e:
            messages.error(request, str(e))
        except Exception as e:
            messages.error(request, f"Error al actualizar el perfil: {str(e)}")

        context = {
            "empleado": empleado,
            "fecha_mostrada": fecha_mostrada,
        }
        return render(request, 'empleados/edit_profile.html', context)

    context = {
        "empleado": empleado,
        "fecha_mostrada": fecha_mostrada,
    }
    return render(request, 'empleados/edit_profile.html', context)
from django.contrib.auth.models import User
from django.shortcuts import render
from .models import EmailVerificationToken  # Ensure this is imported
from django.contrib.auth import get_user_model
from django.shortcuts import render
from .models import EmailVerificationToken  # Asegúrate de que este modelo esté importado

User = get_user_model()

def verify_email(request, token):
    # Check if user is authenticated
    if not request.user.is_authenticated:
        return render(request, 'registration/confirm_email_change.html', {
            "empleado": None,
            "fecha_mostrada": "Nunca",
            "error": "Debes iniciar sesión para verificar tu correo."
        })

    try:
        # Query the token, ensuring it matches the logged-in user and is not verified
        verification_token = EmailVerificationToken.objects.get(
            token=token, 
            user=request.user, 
            is_verified=False
        )
        
        # Check if the new email is already in use by another user
        if User.objects.exclude(pk=request.user.pk).filter(email=verification_token.new_email).exists():
            return render(request, 'registration/confirm_email_change.html', {
                "empleado": request.user,
                "fecha_mostrada": "Nunca",
                "error": "Este correo ya está en uso por otro usuario."
            })

        # Update the user's email and save
        request.user.email = verification_token.new_email
        request.user.save()

        # Mark the token as verified
        verification_token.is_verified = True
        verification_token.save()

        return render(request, 'registration/confirm_email_change.html', {
            "empleado": request.user,
            "fecha_mostrada": "Nunca",
            "success": "Email verificado correctamente."
        })

    except EmailVerificationToken.DoesNotExist:
        return render(request, 'registration/confirm_email_change.html', {
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