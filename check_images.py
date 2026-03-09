from app.database import engine
import pymysql

def check_image_urls():
    connection = engine.raw_connection()
    try:
        with connection.cursor() as cursor:
            # Check chefs table
            cursor.execute("SELECT image_url FROM chefs WHERE image_url IS NOT NULL AND image_url != ''")
            chef_imgs = cursor.fetchall()
            print(f"Chef images: {chef_imgs}")

            # Check dishes table
            cursor.execute("SELECT image_url FROM dishes WHERE image_url IS NOT NULL AND image_url != ''")
            dish_imgs = cursor.fetchall()
            print(f"Dish images: {dish_imgs}")
    finally:
        connection.close()

if __name__ == "__main__":
    check_image_urls()
