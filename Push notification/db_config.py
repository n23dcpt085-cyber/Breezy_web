# db_config.py
import mysql.connector

def get_connection():
    return mysql.connector.connect(
        user="root",
        password="123456",
        host="localhost",
        database="atm_demo"
    )
# db_config.py
import mysql.connector

def get_connection():
    return mysql.connector.connect(
        user="root",
        password="123456",
        host="localhost",
        database="atm_demo"
    )
