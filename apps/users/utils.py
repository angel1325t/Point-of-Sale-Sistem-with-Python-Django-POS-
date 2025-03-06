# my_app/utils.py
import random
import string

def generate_random_password(length=9):
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for _ in range(length))
