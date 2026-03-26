import pymysql

# Database connection details
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'db': 'localfoodies',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}

def migrate():
    connection = pymysql.connect(**DB_CONFIG)
    try:
        with connection.cursor() as cursor:
            # Add status timestamps
            # (accepted_at, preparing_at, out_for_delivery_at, delivered_at are already there in original models.py but maybe not in real DB)
            # Let's check what's there first
            cursor.execute("DESCRIBE orders")
            existing_columns = [col['Field'] for col in cursor.fetchall()]
            
            new_columns = [
                ("ready_at", "DATETIME NULL"),
                ("current_latitude", "DOUBLE NULL"),
                ("current_longitude", "DOUBLE NULL"),
                ("destination_latitude", "DOUBLE NULL"),
                ("destination_longitude", "DOUBLE NULL"),
                ("tracking_enabled", "BOOLEAN DEFAULT FALSE"),
                ("last_location_updated_at", "DATETIME NULL"),
                ("estimated_arrival_minutes", "INT NULL"),
                ("remaining_distance_km", "DOUBLE NULL")
            ]
            
            for col_name, col_type in new_columns:
                if col_name not in existing_columns:
                    print(f"Adding column {col_name}...")
                    cursor.execute(f"ALTER TABLE orders ADD COLUMN {col_name} {col_type}")
                    print(f"Column {col_name} added.")
                else:
                    print(f"Column {col_name} already exists.")
            
            connection.commit()
            print("Migration completed successfully.")
    except Exception as e:
        print(f"Error during migration: {e}")
    finally:
        connection.close()

if __name__ == "__main__":
    migrate()
