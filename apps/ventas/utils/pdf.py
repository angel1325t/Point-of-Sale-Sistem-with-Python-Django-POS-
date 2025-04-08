from django.template.loader import render_to_string
from weasyprint import HTML
import tempfile

def render_to_pdf(template_src, context_dict):
    html_string = render_to_string(template_src, context_dict)
    
    with tempfile.NamedTemporaryFile(delete=True, suffix=".pdf") as output:
        HTML(string=html_string).write_pdf(output.name)
        output.seek(0)
        return output.read()
