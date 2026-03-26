import pymysql
import sys

def update_orders_table():
    # Connection details from app/database.py: DATABASE_URL = "mysql+pymysql://root:@localhost/localfoodies"
    try:
        connection = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            database='localfoodies'
        )
        print("Connected to database successfully.")
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return

    try:
        with connection.cursor() as cursor:
            # Columns to add to 'orders' table
            columns = [
                ("payment_method", "VARCHAR(100)"),
                ("delivery_address", "VARCHAR(255)"),
                ("latitude", "FLOAT"),
                ("longitude", "FLOAT"),
                ("customer_name", "VARCHAR(100)"),
                ("customer_phone", "VARCHAR(20)")
            ]
            
            for col_name, col_type in columns:
                try:
                    query = f"ALTER TABLE orders ADD COLUMN {col_name} {col_type}"
                    cursor.execute(query)
                    print(f"Added column {col_name} successfully.")
                except Exception as e:
                    if "Duplicate column name" in str(e):
                        print(f"Column {col_name} already exists.")
                    else:
                        print(f"Error adding column {col_name}: {e}")
            
            connection.commit()
            print("Finished updating orders table.")
    finally:
        connection.close()

if __name__ == "__main__":
    update_orders_table()
