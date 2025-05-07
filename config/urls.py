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

from django.urls import path, include
from django.contrib import admin
from django.contrib.auth.decorators import login_required
from apps.ventas.views import income_expenses_data, top_products_data, sales_by_categories, chart_data,sale_pdf
from apps.returns.views import devoluciones_por_periodo, productos_mas_devueltos, motivos_devolucion_data, return_pdf
from django.conf import settings
from django.conf.urls.static import static
from django.http import HttpResponseForbidden
from django.contrib.auth import views as auth_views
from .manual.support_bot import chat


urlpatterns = [
    path(
        "admin/login/",
        lambda request: HttpResponseForbidden("Acceso prohibido"),
        name="admin_login_blocked",
    ),
    path("admin/", admin.site.urls),  # Mantén las demás rutas de admin si las necesitas
    path("accounts/", include("django.contrib.auth.urls")),
    path("", include("apps.users.urls")),
    path("empleados/", include("apps.productos.urls")),
    path("empleados/", include("apps.returns.urls")),
    path("empleados/", include("apps.ventas.urls")),
    path("i18n/", include("django.conf.urls.i18n")),
    path('ingresos_egresos_data/', income_expenses_data, name='ingresos_egresos_data'),
    path('top_productos_data/', top_products_data, name='top_productos_data'),
    path('ventas_por_categoria_data/', sales_by_categories, name='ventas_por_categoria_data'),
    path("api/chartdata/", chart_data, name="chart_data"),
    path('devoluciones_por_periodo/', devoluciones_por_periodo, name='devoluciones_por_periodo'),
    path('productos_mas_devueltos/', productos_mas_devueltos, name='productos_mas_devueltos'),
    path('motivos_devolucion_data/', motivos_devolucion_data, name='motivos_devolucion_data'),
    path("accounts/password_reset/",auth_views.PasswordResetView.as_view(template_name="registration/password_reset_form.html",email_template_name="registration/password_reset_email.html"),name="password_reset",),
    path('accounts/password_reset/done/', auth_views.PasswordResetDoneView.as_view(), name='password_reset_done'),
    path('accounts/reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(), name='password_reset_confirm'),
    path('accounts/reset/done/', auth_views.PasswordResetCompleteView.as_view(), name='password_reset_complete'),
    path('accounts/password_change/', auth_views.PasswordChangeView.as_view(template_name='registration/password_change_form.html'), name='password_change'),
    path('accounts/password_change/done/', auth_views.PasswordChangeDoneView.as_view(template_name='registration/password_change_done.html'), name='password_change_done'),
    path("download-sale-report/", sale_pdf, name="sale_pdf"),
    path('download-return-report/', return_pdf, name='return_pdf'),
    path('chat/', chat, name='chat'),
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
