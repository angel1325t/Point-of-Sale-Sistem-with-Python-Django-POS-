from django.contrib import admin
from django.utils.html import format_html
from django.utils.translation import gettext_lazy as _
from .models import CustomUser
from .forms import CustomUserForm
from django.contrib.auth.models import Group


class CustomUserAdmin(admin.ModelAdmin):
    form = CustomUserForm
    list_display = ('username', 'email', 'is_superuser', 'is_active', 'profile_image_display', 'groups_display')
    list_filter = ('is_superuser', 'is_active', 'groups')
    list_per_page = 5
    search_fields = ('username', 'email', 'id')
    actions = ['disable_users', 'delete_selected', 'enable_users']
    
    fieldsets = (
        (None, {
            'fields': ['email']  # Manteniendo el formato con listas
        }),
        ('Permisos', {
            'fields': ['is_superuser', 'is_staff', 'is_active', 'groups'],  # Moviendo 'groups' aquí
        }),
    )


    def profile_image_display(self, obj):
        if obj.profile_image:
            return format_html(
                '<img src="{}" width="50" height="50" style="border-radius: 50%; object-fit: cover;" />',
                obj.profile_image.url
            )
        else:
            default_image_url = '/static/img/default_profile.png'
            return format_html(
                '<img src="{}" width="50" height="50" style="border-radius: 50%; object-fit: cover;" />',
                default_image_url
            )

    profile_image_display.short_description = "Profile Image"

    def groups_display(self, obj):
        return ", ".join([group.name for group in obj.groups.all()])  # Mostrar nombres de los grupos

    groups_display.short_description = "Groups"

    def get_fieldsets(self, request, obj=None):
        fieldsets = super().get_fieldsets(request, obj)
        for fieldset in fieldsets:
            if 'username' in fieldset[1]['fields']:
                fieldset[1]['fields'] = tuple(f for f in fieldset[1]['fields'] if f != 'username')
        return fieldsets

    # Acción personalizada para deshabilitar usuarios
    @admin.action(description=_("Disable selected users"))
    def disable_users(self, request, queryset):
        queryset.update(is_active=False)

    @admin.action(description=_("Enable selected users"))
    def enable_users(self, request, queryset):
        queryset.update(is_active=True)


# Registrar el modelo
admin.site.register(CustomUser, CustomUserAdmin)
