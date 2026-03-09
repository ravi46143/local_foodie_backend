import pymysql
from app.database import engine

def update_schema():
    connection = engine.raw_connection()
    try:
        with connection.cursor() as cursor:
            # Update chefs table
            try:
                cursor.execute("ALTER TABLE chefs ADD COLUMN latitude FLOAT")
                print("Added latitude to chefs")
            except Exception as e: print(f"Chefs latitude: {e}")
            
            try:
                cursor.execute("ALTER TABLE chefs ADD COLUMN longitude FLOAT")
                print("Added longitude to chefs")
            except Exception as e: print(f"Chefs longitude: {e}")
            
            try:
                cursor.execute("ALTER TABLE chefs ADD COLUMN address VARCHAR(255)")
                print("Added address to chefs")
            except Exception as e: print(f"Chefs address: {e}")
            
            try:
                cursor.execute("ALTER TABLE chefs ADD COLUMN bio TEXT")
                print("Added bio to chefs")
            except Exception as e: print(f"Chefs bio: {e}")
            
            try:
                cursor.execute("ALTER TABLE chefs ADD COLUMN kitchen_name VARCHAR(100)")
                cursor.execute("ALTER TABLE chefs ADD COLUMN experience VARCHAR(50)")
                cursor.execute("ALTER TABLE chefs ADD COLUMN daily_meals VARCHAR(50)")
                cursor.execute("ALTER TABLE chefs ADD COLUMN cuisine_type VARCHAR(100)")
                cursor.execute("ALTER TABLE chefs ADD COLUMN food_category VARCHAR(100)")
                print("Added onboarding columns to chefs")
            except Exception as e: print(f"Chefs onboarding: {e}")

            try:
                cursor.execute("ALTER TABLE dishes ADD COLUMN description TEXT")
                cursor.execute("ALTER TABLE dishes ADD COLUMN cuisine VARCHAR(50)")
                cursor.execute("ALTER TABLE dishes ADD COLUMN food_type VARCHAR(50)")
                print("Added detail columns to dishes")
            except Exception as e: print(f"Dishes details: {e}")

            # Update addresses table
            try:
                cursor.execute("ALTER TABLE addresses ADD COLUMN latitude FLOAT")
                print("Added latitude to addresses")
            except Exception as e: print(f"Addresses latitude: {e}")
            
            try:
                cursor.execute("ALTER TABLE addresses ADD COLUMN longitude FLOAT")
                print("Added longitude to addresses")
            except Exception as e: print(f"Addresses longitude: {e}")
            
        connection.commit()
        print("Schema update completed successfully.")
    finally:
        connection.close()

if __name__ == "__main__":
    update_schema()
