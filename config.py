# config.py
# This file contains all configuration variables for the application.

import os

class Config:
    """
    Base configuration class.
    Contains database credentials and the secret key.
    """
    # --- Secret Key Configuration ---
    # It's important to keep this secret.
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_very_long_and_random_secret_key_12345'

    # --- Database Configuration ---
    # These details are loaded by app.py to connect to the database.
    MYSQL_HOST = 'localhost'
    MYSQL_USER = 'root'
    MYSQL_PASSWORD = '01988087533' # Make sure this password is correct for your system
    MYSQL_DB = 'carrentaldb'
    MYSQL_CURSORCLASS = 'DictCursor'