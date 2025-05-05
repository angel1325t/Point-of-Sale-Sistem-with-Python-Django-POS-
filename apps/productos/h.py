import google.generativeai as genai
import PyPDF2
from pathlib import Path

API_KEY = 'AIzaSyAX8slgPSKHkqia1wqoOa1fPNJTOC0kQfc'
genai.configure(api_key=API_KEY)

model = genai.GenerativeModel('gemini-2.0-flash')

def extract_text_from_pdf(pdf_path):
    """Lee el pdf y extrae el texto."""
    pdf_path = Path(pdf_path)
    if not pdf_path.exists():
        print(f"Error: No se encontró el archivo {pdf_path}.")
        return None
    
    try:
        with pdf_path.open('rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ''
            for page in reader.pages:
                text += page.extract_text() or ''
            return text if text.strip() else None
    except Exception as e:
        print(f"Error al leer el PDF: {e}")
        return None

PROMPT = """
Eres un experto en el tema del PDF. Usa este contenido para responder:

{content}

Pregunta: {user_input}

Responde de forma clara, precisa y con una longitud media dependiendo lo que te pregunte deberas responder mas o menos largo si te pido que respondas en un idioma usa ese idioma siempre pero por defecto usa español.
"""

def start_chat(pdf_text):
    """Inicia un chat donde la IA responde según el PDF."""
    chat = model.start_chat()
    print("Chat iniciado. Pregunta sobre el PDF o escribe 'exit' para salir.")
    
    while True:
        user_input = input("Tú: ").strip()
        if user_input.lower() == 'exit':
            print("Chat terminado.")
            break
        if not user_input:
            print("Por favor, escribe una pregunta.")
            continue
        
        prompt = PROMPT.format(content=pdf_text, user_input=user_input)
        
        try:
            response = chat.send_message(prompt)
            print(f"AI: {response.text}")
        except Exception as e:
            print(f"Error al responder: {e}")

def main():
    """Corre el programa"""
    pdf_path = 'apps/productos/prueba2.pdf'
    pdf_text = extract_text_from_pdf(pdf_path)
    
    if not pdf_text:
        print("No se pudo leer el PDF. Finalizando...")
        return
    
    start_chat(pdf_text)

if __name__ == "__main__":
    main()