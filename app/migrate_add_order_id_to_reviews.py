"""
Run this script AFTER the backend has started at least once (so DB tables are created).
Execute from the backend app folder:
  cd C:\xampp\htdocs\localfoodies\app
  python migrate_add_order_id_to_reviews.py
"""
import sqlite3
import os

# The DB is created in the app folder
DB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "localfoodies.db")

def migrate():
    if not os.path.exists(DB_PATH):
        print(f"Database not found at: {DB_PATH}")
        print("Please start the backend server first so the database is created, then run this script.")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Check if the 'reviews' table exists at all
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table' AND name='reviews'")
    if cursor.fetchone() is None:
        print("The 'reviews' table doesn't exist yet.")
        print("Please start the backend server first so all tables are created, then re-run this script.")
        conn.close()
        return

    # Check if column already exists
    cursor.execute("PRAGMA table_info(reviews)")
    columns = [row[1] for row in cursor.fetchall()]

    if "order_id" not in columns:
        print("Adding order_id column to reviews table...")
        cursor.execute("ALTER TABLE reviews ADD COLUMN order_id INTEGER REFERENCES orders(id)")
        conn.commit()
        print("✓ Migration complete! order_id column added to reviews.")
    else:
        print("✓ Column 'order_id' already exists. No migration needed.")

    conn.close()

if __name__ == "__main__":
    migrate()
