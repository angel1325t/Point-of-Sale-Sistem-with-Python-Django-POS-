from django.apps import AppConfig


class ReturnsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "apps.returns"
    
    def ready(self):
        import apps.returns.signals