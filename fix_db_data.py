import pymysql

def fix_data():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='',
        database='localfoodies'
    )
    
    try:
        with connection.cursor() as cursor:
            # Check existing data
            cursor.execute("SELECT id, email, phone FROM chefs")
            rows = cursor.fetchall()
            print(f"Current rows in chefs: {rows}")
            
            # If there are rows with empty email/phone, they will block the UNIQUE constraint.
            # For development, we can just assign dummy values based on ID if they are empty.
            for row in rows:
                chef_id, email, phone = row
                updates = []
                if not email or email == '':
                    updates.append(f"email = 'chef{chef_id}@example.com'")
                if not phone or phone == '':
                    updates.append(f"phone = '0000000{chef_id}'")
                if not row[0]: # full_name might be empty too
                    updates.append(f"full_name = 'Chef {chef_id}'")
                
                # Check password
                cursor.execute(f"SELECT password FROM chefs WHERE id = {chef_id}")
                pwd = cursor.fetchone()[0]
                if not pwd:
                    updates.append("password = 'hashed_dummy_password'") # Just to avoid NOT NULL error

                if updates:
                    sql = f"UPDATE chefs SET {', '.join(updates)} WHERE id = {chef_id}"
                    print(f"Running: {sql}")
                    cursor.execute(sql)
            
            # Now try adding unique constraints again
            print("Adding unique constraint on email...")
            try:
                cursor.execute("ALTER TABLE chefs ADD UNIQUE (email)")
                print("Added unique constraint on email")
            except Exception as e:
                print(f"Email constraint error: {e}")
                
            print("Adding unique constraint on phone...")
            try:
                cursor.execute("ALTER TABLE chefs ADD UNIQUE (phone)")
                print("Added unique constraint on phone")
            except Exception as e:
                print(f"Phone constraint error: {e}")

            connection.commit()
            print("Database data and constraints fixed.")
            
    finally:
        connection.close()

if __name__ == "__main__":
    fix_data()
