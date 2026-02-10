# Database configuration - use standalone imports to avoid circular import with chatbot
import mysql.connector
from mysql.connector import Error

DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'qaz123QAZ!@#',
    'database': 'hrms',
    'port': 3306,
    'autocommit': True
}


def get_db_connection():
    try:
        return mysql.connector.connect(**DB_CONFIG)
    except Error as e:
        print("Error connecting to MySQL:", e)
        return None
