from django import forms
from .models import Producto, Categoria, Suministradores

class AddProductForm(forms.ModelForm):
    class Meta:
        model = Producto
        fields = [
            "nombre",
            "descripcion",
            "precio",
            "stock",
            "image",
            "activo",
            "marca",
            "categoria",
            "suministrador",
        ]
        widgets = {
            "nombre": forms.TextInput(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Nombre del producto",
                    "autofocus": "true",
                }
            ),
            "marca": forms.TextInput(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Marca del Producto",
                }
            ),
            "descripcion": forms.Textarea(
                attrs={
                    "class": "form-control mb-3",
                    "rows": 3,
                    "placeholder": "Descripción del producto",
                }
            ),
            "precio": forms.NumberInput(
                attrs={
                    "class": "form-control mb-3",
                    "step": "0.01",
                    "placeholder": "Precio del producto",
                }
            ),
            "costo": forms.NumberInput(
                attrs={
                    "class": "form-control mb-3",
                    "step": "0.01",
                    "placeholder": "costo del producto",
                }
            ),
            "descuento": forms.NumberInput(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "descuento del producto",
                }
            ),
            "stock": forms.NumberInput(
                attrs={
                    "class": "form-control mb-3",
                    "min": "0",
                    "placeholder": "Cantidad en stock",
                }
            ),
            "image": forms.ClearableFileInput(
                attrs={
                    "class": "form-control-file mb-3",
                    "accept": "image/*",
                    "placeholder": "Seleccionar imagen",
                    "style": """
                        display: block;
                        width: 100%;
                        padding: 0.375rem 0.75rem;
                        font-size: 1rem;
                        font-weight: 400;
                        line-height: 1.5;
                        color: #fff;
                        background-color: #343A40;
                        border: 1px solid #fff;
                        border-radius: 0.375rem;
                        transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                    """,
                }
            ),
            "activo": forms.CheckboxInput(
                attrs={
                    "class": "form-check-input",
                }
            ),
            "categoria": forms.Select(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Seleccionar categoría",
                }
            ),
            "suministrador": forms.Select(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Seleccionar suministrador",
                }
            ),
        }
class CategoriaForm(forms.ModelForm):
    class Meta:
        model = Categoria
        fields = ["nombre_categoria", "descripcion_categoria"]

    nombre_categoria = forms.CharField(
        max_length=255,
        widget=forms.TextInput(
            attrs={
                "class": "form-control mb-3",
                "placeholder": "Nombre de la categoría",
            }
        ),
    )
    descripcion_categoria = forms.CharField(
        widget=forms.Textarea(
            attrs={
                "class": "form-control mb-3",
                "rows": 4,
                "placeholder": "Descripción de la categoría",
            }
        ),
        required=False,
    )


class SuministradoresForm(forms.ModelForm):
    class Meta:
        model = Suministradores
        fields = ["nombre_proveedor", "telefono", "email", "direccion"]

        widgets = {
            "nombre_proveedor": forms.TextInput(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Nombre del proveedor",
                    "autofocus": "true",
                }
            ),
            "telefono": forms.TextInput(
            attrs={
                "class": "form-control mb-3",
                "placeholder": "Número de teléfono",
                "pattern": "[0-9+()-\s]+",  # Solo permite números, +, (), - y espacios
                "title": "Ingrese un número de teléfono válido.",
            }
        ),
            "email": forms.EmailInput(
                attrs={
                    "class": "form-control mb-3",
                    "placeholder": "Correo electrónico",
                }
            ),
            "direccion": forms.Textarea(
                attrs={
                    "class": "form-control mb-3",
                    "rows": 3,
                    "placeholder": "Dirección del proveedor",
                }
            ),
        }
