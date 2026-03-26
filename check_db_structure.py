import pymysql

def check_structure():
    try:
        connection = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            database='localfoodies'
        )
        with connection.cursor() as cursor:
            cursor.execute("DESCRIBE orders")
            columns = cursor.fetchall()
            print("Columns in 'orders' table:")
            for col in columns:
                print(col)
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    check_structure()
