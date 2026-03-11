import mysql.connector
from backend.config import DATABASE_NAME, DATABASE_HOST, DATABASE_USER, DATABASE_PASSWORD

def get_connection():
    connection = mysql.connector.connect(
        host=DATABASE_HOST,
        user=DATABASE_USER,
        password=DATABASE_PASSWORD,
        database=DATABASE_NAME
    )

    return connection
