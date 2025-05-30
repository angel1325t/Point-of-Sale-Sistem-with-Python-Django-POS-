"""
URL configuration for config project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path
from . import views

urlpatterns = [
    path("login/", views.login_view, name='login'),  
    path("", views.splash, name='splash'), 
    path("disabled/", views.disabled_user_view, name='disabled_user'),  
    path("problem/", views.technical_problem_view, name="technical_problem"), 
    path("logout/", views.logout_view, name='logout'), 
    path('email/<int:id>/', views.CreateCredentialsView.as_view(), name='email'),
    path('empleados/perfil/', views.profile, name='profile'),
    path('empleados/perfil/cambiar-imagen/', views.update_profile_picture, name='update_profile_picture'),
    path('verificar-email/<uuid:token>/', views.verify_email, name='verify_email'),
    
]
