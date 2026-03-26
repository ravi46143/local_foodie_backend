"""
Migration: Add order status timestamp columns
Run: python migrate_timestamps.py
"""
from app.database import engine
from sqlalchemy import inspect, text

inspector = inspect(engine)
cols = [c['name'] for c in inspector.get_columns('orders')]
print('Existing columns:', cols)

additions = {
    'updated_at': 'ALTER TABLE orders ADD COLUMN updated_at DATETIME',
    'accepted_at': 'ALTER TABLE orders ADD COLUMN accepted_at DATETIME',
    'preparing_at': 'ALTER TABLE orders ADD COLUMN preparing_at DATETIME',
    'out_for_delivery_at': 'ALTER TABLE orders ADD COLUMN out_for_delivery_at DATETIME',
    'delivered_at': 'ALTER TABLE orders ADD COLUMN delivered_at DATETIME',
}

with engine.connect() as conn:
    for col_name, sql in additions.items():
        if col_name not in cols:
            conn.execute(text(sql))
            print(f'Added column: {col_name}')
        else:
            print(f'Already exists: {col_name}')
    conn.commit()

print('Migration complete!')
