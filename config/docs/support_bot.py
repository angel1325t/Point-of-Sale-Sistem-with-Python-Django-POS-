import os
import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_protect
from django.views.decorators.http import require_POST
import google.generativeai as genai
from pathlib import Path
import PyPDF2

# Configure Google Generative AI
genai.configure(api_key=os.environ.get('GOOGLE_API_KEY'))

model = genai.GenerativeModel('gemini-2.0-flash')

# Extract text from PDF
def extract_text_from_pdf(pdf_path):
    pdf_path = Path(pdf_path)
    if not pdf_path.exists():
        return None
    try:
        with pdf_path.open('rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ''
            for page in reader.pages:
                text += page.extract_text() or ''
            return text if text.strip() else None
    except Exception:
        return None

# Load PDF text once at startup
PDF_PATH = 'config/docs/Manual de uso.pdf'
PDF_TEXT = extract_text_from_pdf(PDF_PATH)

PROMPT = """
Eres un experto en el tema del PDF. Usa este contenido para responder:

{content}

Pregunta: {user_input}

Responde de forma clara, precisa y con una longitud corta dependiendo lo que te pregunte deberas responder mas o menos largo si te pido que respondas en un idioma usa ese idioma siempre pero por defecto usa español.
"""

@csrf_protect
@require_POST
def chat(request):
    if not PDF_TEXT:
        return JsonResponse({'error': 'No se pudo leer el PDF'}, status=500)

    try:
        data = json.loads(request.body)
        user_input = data.get('message', '').strip()
        if not user_input:
            return JsonResponse({'error': 'Mensaje vacío'}, status=400)

        chat = model.start_chat()
        prompt = PROMPT.format(content=PDF_TEXT, user_input=user_input)
        response = chat.send_message(prompt)
        
        return JsonResponse({'response': response.text})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)