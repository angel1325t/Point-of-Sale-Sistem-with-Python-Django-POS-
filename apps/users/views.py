from django.contrib.auth import logout, login, authenticate
from django.contrib.auth import get_user_model
from django.views.decorators.csrf import csrf_protect
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponseForbidden, HttpResponse
from django.contrib import messages
from django.contrib.auth.hashers import make_password
from django.views import View
import os

CustomUser = get_user_model()


# Mantener como FBV porque es simple y maneja autenticación
from django.contrib.auth import get_user_model

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
        username = request.POST.get("username")
        password = request.POST.get("password")

        if not username:
            messages.error(request, "El nombre de usuario es obligatorio.")
            return redirect("login")

        if not password:
            messages.error(request, "La contraseña es obligatoria.")
            return redirect("login")

        # Verificar si el usuario existe antes de autenticar
        User = get_user_model()
        try:
            user = User.objects.get(username=username)
            if not user.is_active:
                return redirect("disabled_user")  # Redirige si el usuario está inactivo
        except User.DoesNotExist:
            user = None

        # Intentar autenticar solo si el usuario existe
        if user:
            user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)

            if user.is_superuser or user.groups.filter(name="Gerente").exists():
                return redirect("admin:index")
            if user.groups.filter(name="Vendedor").exists():
                return redirect("ventas")
            if user.groups.filter(name="Almacén").exists():
                return redirect("products")

            return redirect("technical_problem")

        messages.error(request, "Nombre de usuario o contraseña incorrectos.")
        return redirect("login")

    return render(request, "registration/login.html")


def disabled_user_view(request):
    return render(request, "registration/disable_user.html")

def technical_problem_view(request):
    return render(request, "registration/technical_problem.html")


# Mantener como FBV porque solo cierra sesión y redirige
def logout_view(request):
    logout(request)
    return redirect("/")


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