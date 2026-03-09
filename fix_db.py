import pymysql

def fix_schema():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='',
        database='localfoodies'
    )
    
    try:
        with connection.cursor() as cursor:
            # Check for missing columns and add them
            columns_to_add = [
                ("full_name", "VARCHAR(100) NOT NULL"),
                ("email", "VARCHAR(100) NOT NULL"),
                ("phone", "VARCHAR(15) NOT NULL"),
                ("password", "VARCHAR(255) NOT NULL"),
                ("role", "VARCHAR(50) DEFAULT 'chef'"),
                ("kitchen_name", "VARCHAR(100) NOT NULL"),
                ("experience", "VARCHAR(50) NOT NULL"),
                ("daily_meals", "VARCHAR(50) NOT NULL"),
                ("cuisine_type", "VARCHAR(100) NOT NULL"),
                ("food_category", "VARCHAR(100) NOT NULL")
            ]
            
            for col_name, col_def in columns_to_add:
                try:
                    print(f"Adding column {col_name}...")
                    cursor.execute(f"ALTER TABLE chefs ADD COLUMN {col_name} {col_def}")
                    print(f"Added column {col_name}")
                except Exception as e:
                    if "Duplicate column name" in str(e):
                        print(f"Column {col_name} already exists.")
                    else:
                        print(f"Error adding {col_name}: {e}")
            
            # Add unique constraints if they don't exist
            try:
                cursor.execute("ALTER TABLE chefs ADD UNIQUE (email)")
            except Exception as e:
                print(f"Unique constraint on email: {e}")
                
            try:
                cursor.execute("ALTER TABLE chefs ADD UNIQUE (phone)")
            except Exception as e:
                print(f"Unique constraint on phone: {e}")

            connection.commit()
            print("Database schema updated successfully.")
            
    finally:
        connection.close()

if __name__ == "__main__":
    fix_schema()
