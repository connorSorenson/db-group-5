import os
import pymysql

# Connect to the database
def connect_to_database():
    try:
        conn = pymysql.connect(
            host='database-group5.cdzoz9uage3b.us-east-2.rds.amazonaws.com',
            user='admin',
            password='',
            # database='database-group5',
            port=3306
        )
        print("Connected to the database.")
    # ... perform database operations ...

    # Don't forget to commit if you make changes to the database
    # conn.commit()

    except pymysql.MySQLError as e:
        print(f"An error occurred: {e}")
        conn = None

    return conn

def execute_sql_script(connection, script_path):
    with open(script_path, 'r') as file:
        sql_script = file.read()
    
    try:
        with connection.cursor() as cursor:
            for statement in sql_script.split(';'):
                if statement.strip():
                    cursor.execute(statement)
        connection.commit()
        print("SQL script executed successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
        connection.rollback()

def main():
    connection = connect_to_database()
    if connection:
        try:
            execute_sql_script(connection, 'path_to_your_sql_script.sql')  # Replace with the path to your SQL script
        finally:
            connection.close()
    else:
        print("Database connection could not be established.")