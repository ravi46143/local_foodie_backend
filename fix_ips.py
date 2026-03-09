from app.database import engine
import pymysql

OLD_IP = "10.235.248.239"
NEW_IP = "10.164.109.239"

def fix_image_urls():
    connection = engine.raw_connection()
    try:
        with connection.cursor() as cursor:
            # Update chefs table
            cursor.execute(f"UPDATE chefs SET image_url = REPLACE(image_url, '{OLD_IP}', '{NEW_IP}') WHERE image_url LIKE '%{OLD_IP}%'")
            chef_count = cursor.rowcount
            print(f"Updated {chef_count} chef images")

            # Update dishes table
            cursor.execute(f"UPDATE dishes SET image_url = REPLACE(image_url, '{OLD_IP}', '{NEW_IP}') WHERE image_url LIKE '%{OLD_IP}%'")
            dish_count = cursor.rowcount
            print(f"Updated {dish_count} dish images")
        
        connection.commit()
        print("Database update completed successfully.")
    finally:
        connection.close()

if __name__ == "__main__":
    fix_image_urls()
