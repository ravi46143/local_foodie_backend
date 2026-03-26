import pymysql

def migrate():
    try:
        connection = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            database='localfoodies'
        )
        with connection.cursor() as cursor:
            # Columns to add to 'orders' table
            columns = [
                ("payment_method", "VARCHAR(100)"),
                ("delivery_address", "VARCHAR(255)"),
                ("latitude", "FLOAT"),
                ("longitude", "FLOAT"),
                ("customer_name", "VARCHAR(100)"),
                ("customer_phone", "VARCHAR(20)"),
                ("delivery_fee", "FLOAT DEFAULT 30.0"),
                ("platform_fee", "FLOAT DEFAULT 21.0"),
                ("chef_earnings", "FLOAT")
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
            print("Migration completed successfully.")
    except Exception as e:
        print(f"Critical error: {e}")
    finally:
        if 'connection' in locals():
            connection.close()

if __name__ == "__main__":
    migrate()
