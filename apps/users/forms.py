from django import forms
from .models import CustomUser
from .utils import generate_random_password
from .email_service import EmailService
from django.contrib.auth.models import Group


class CustomUserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.HiddenInput(), required=False)
    profile_image = forms.ImageField(widget=forms.HiddenInput(), required=False)
    email = forms.EmailField(
        required=True,
        widget=forms.EmailInput(attrs={
            'class': 'form-control',
            'placeholder': 'Ingrese el correo electrónico',
            'style': 'width: 100%; padding: 8px; border-radius: 5px; background-color: white; color: black; border: 1px solid #ccc;'
        })
    )
    is_superuser = forms.BooleanField(required=False, label="Es superusuario")
    is_staff = forms.BooleanField(required=False, label="Es staff", initial=False)
    first_name = forms.CharField(widget=forms.HiddenInput(), required=False)
    last_name = forms.CharField(widget=forms.HiddenInput(), required=False)
    groups = forms.ModelMultipleChoiceField(
        queryset=Group.objects.all(),
        required=False,
        widget=forms.Select,
        label="Grupos"
    )

    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'first_name', 'last_name', 'is_superuser', 'is_staff', 'is_active', 'profile_image', 'groups']

    def save(self, commit=True):
        user = super().save(commit=False)

        if not user.username and user.email:
            user.username = user.email.split('@')[0]

        if not user.pk:
            random_password = generate_random_password()
            user.set_password(random_password)
        else:
            random_password = None

        user.is_superuser = self.cleaned_data.get("is_superuser", False)
        user.is_active = self.cleaned_data.get("is_active", True)
        user.is_staff = self.cleaned_data.get("is_staff", False)

        user.save()

        if self.cleaned_data.get('profile_image'):
            user.profile_image = self.cleaned_data['profile_image']
            user.save()

        # Asignar los grupos seleccionados
        groups = self.cleaned_data.get('groups', [])
        if groups:
            user.groups.set(groups)

        if random_password:
            self.send_credentials_email(user.id, user, random_password)

        return user

    def send_credentials_email(self, id, user, password):
        email_service = EmailService(id, user, password)
        email_service.send_email()

    def clean_email(self):
        email = self.cleaned_data.get('email')
        # Validar el correo electrónico usando la API de Hunter.io
        # email_validator = EmailValidator(email)
        # email_validator.validate()
        return email
