import pymysql
from app.database import SessionLocal, engine
from app.models import Base, Chef, Dish, Wallet, User, Review

def seed_data():
    # Create tables if they don't exist
    Base.metadata.create_all(bind=engine)
    
    db = SessionLocal()
    
    # --- 1. Maria (South Indian) ---
    chef_maria_user = get_or_create_user(db, "Chef Maria", "maria@example.com", "1234567890")
    maria_kitchen = get_or_create_chef(db, chef_maria_user.id, "Maria's Home Kitchen", 4.8, "South Indian, Home Style", "30-45 min", "https://images.unsplash.com/photo-1556910103-1c02745aae4d", lat=12.9716, lon=77.5946, address="MG Road, Bangalore")
    
    maria_dishes = [
        ("Masala Dosa", 60.0, 4.9, True, "Breakfast", "Best Seller", "https://images.unsplash.com/photo-1589302168068-964664d93dc0"),
        ("Idli Sambhar", 40.0, 4.7, True, "Breakfast", None, "https://images.unsplash.com/photo-1589301760014-d929f3979dbc"),
        ("Pongal", 50.0, 4.6, True, "Breakfast", None, "https://images.unsplash.com/photo-1610192244261-3f33de3f55e4"),
        ("Home Style Meals", 120.0, 4.9, True, "Lunch", "Popular", "https://images.unsplash.com/photo-1546833999-b9f581a1996d"),
        ("Filter Coffee", 25.0, 4.8, True, "Beverages", "Fresh", "https://images.unsplash.com/photo-1544787210-2213d84ad96b"),
        ("Payasam", 45.0, 4.7, True, "Dessert", None, "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4"),
    ]
    add_dishes_with_reviews(db, maria_kitchen.id, maria_dishes)

    # --- 2. Rahul (North Indian) ---
    chef_rahul_user = get_or_create_user(db, "Chef Rahul", "rahul@example.com", "9876543210")
    rahul_kitchen = get_or_create_chef(db, chef_rahul_user.id, "Rahul's Punjabi Rasoi", 4.7, "North Indian, Punjabi", "40-50 min", "https://images.unsplash.com/photo-1585937421612-70a008356fbe", lat=12.9352, lon=77.6245, address="Koramangala, Bangalore")
    
    rahul_dishes = [
        ("Butter Chicken", 250.0, 4.9, False, "Main Course", "Must Try", "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398"),
        ("Paneer Butter Masala", 180.0, 4.8, True, "Main Course", "Creamy", "https://images.unsplash.com/photo-1631452180519-c014fe946bc7"),
        ("Dal Makhani", 160.0, 4.7, True, "Main Course", None, "https://images.unsplash.com/photo-1546833999-b9f581a1996d"),
        ("Garlic Naan", 40.0, 4.6, True, "Bread", None, "https://images.unsplash.com/photo-1601050690597-df0568f70950"),
        ("Lassi", 50.0, 4.8, True, "Beverages", "Chilled", "https://images.unsplash.com/photo-1550583760-705990264b38"),
    ]
    add_dishes_with_reviews(db, rahul_kitchen.id, rahul_dishes)

    # --- 3. Li (Chinese) ---
    chef_li_user = get_or_create_user(db, "Chef Li", "li@example.com", "1122334455")
    li_kitchen = get_or_create_chef(db, chef_li_user.id, "Li's Dragon Wok", 4.6, "Chinese, Thai", "25-35 min", "https://images.unsplash.com/photo-1541696432-82c6da8ce7bf", lat=12.9610, lon=77.6387, address="Indiranagar, Bangalore")
    
    li_dishes = [
        ("Veg Manchurian", 140.0, 4.5, True, "Starters", None, "https://images.unsplash.com/photo-1512058564366-18510be2db19"),
        ("Chicken Hakka Noodles", 160.0, 4.7, False, "Main Course", "Sizzling", "https://images.unsplash.com/photo-1585032226651-759b368d7246"),
        ("Schezwan Fried Rice", 150.0, 4.6, True, "Main Course", "Spicy", "https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec"),
        ("Spring Rolls", 100.0, 4.4, True, "Starters", "Crunchy", "https://images.unsplash.com/photo-1541696432-82c6da8ce7bf"),
    ]
    add_dishes_with_reviews(db, li_kitchen.id, li_dishes)

    # --- 4. Sofia (Desserts & Baking) ---
    chef_sofia_user = get_or_create_user(db, "Chef Sofia", "sofia@example.com", "5544332211")
    sofia_kitchen = get_or_create_chef(db, chef_sofia_user.id, "Sofia's Dessert Studio", 4.9, "Cakes, Pastries, Desserts", "20-30 min", "https://images.unsplash.com/photo-1488477181946-6428a0291777", lat=12.9141, lon=77.6411, address="HSR Layout, Bangalore")
    
    sofia_dishes = [
        ("Chocolate Lava Cake", 120.0, 5.0, True, "Dessert", "Heavenly", "https://images.unsplash.com/photo-1624353365286-3f8d62daad51"),
        ("Blueberry Cheesecake", 150.0, 4.8, True, "Dessert", "Creamy", "https://images.unsplash.com/photo-1533134242443-d4fd215305ad"),
        ("Red Velvet Pastry", 80.0, 4.7, True, "Dessert", None, "https://images.unsplash.com/photo-1616541823729-00fe0aacd32c"),
    ]
    add_dishes_with_reviews(db, sofia_kitchen.id, sofia_dishes)

    # --- 5. Test Customer (NEW) ---
    test_customer = get_or_create_user(db, "Test Customer", "test@example.com", "0000000000", role="customer")
    wallet = db.query(Wallet).filter(Wallet.user_id == test_customer.id).first()
    if wallet:
        wallet.balance = 1000.0
        db.commit()
        print("Updated test customer wallet balance to 1000.0")

    print("Database seeding check complete! Success")
    db.close()

def get_or_create_user(db, name, email, phone, role="chef"):
    user = db.query(User).filter(User.phone == phone).first()
    if not user:
        user = User(full_name=name, email=email, phone=phone, password="password123", role=role)
        db.add(user)
        db.commit()
        db.refresh(user)
        print(f"Created user {name}.")
    return user

def get_or_create_chef(db, user_id, name, rating, cuisines, delivery_time, image_url, lat=0.0, lon=0.0, address="", kitchen_name=None, exp="2 Years", meals="20", cat="Both"):
    chef = db.query(Chef).filter(Chef.user_id == user_id).first()
    if not chef:
        chef = Chef(
            user_id=user_id, 
            name=name, 
            rating=rating, 
            cuisines=cuisines, 
            delivery_time=delivery_time, 
            is_online=True, 
            image_url=image_url, 
            latitude=lat, 
            longitude=lon, 
            address=address,
            kitchen_name=kitchen_name or name,
            experience=exp,
            daily_meals=meals,
            cuisine_type=cuisines.split(',')[0],
            food_category=cat
        )
        db.add(chef)
        db.commit()
        db.refresh(chef)
        print(f"Created chef {name}.")
    return chef

def add_dishes_with_reviews(db, chef_id, dishes_data):
    from app.models import Review
    import random
    
    for name, price, rating, is_veg, category, tag, image_url in dishes_data:
        existing = db.query(Dish).filter(Dish.chef_id == chef_id, Dish.name == name).first()
        if not existing:
            dish = Dish(
                chef_id=chef_id, 
                name=name, 
                price=price, 
                rating=rating, 
                is_veg=is_veg, 
                category=category, 
                tag=tag, 
                image_url=image_url,
                description=f"Delicious {name} prepared with home-style care.",
                cuisine="Indian",
                food_type="Veg" if is_veg else "Non-Veg"
            )
            db.add(dish)
            db.commit()
            db.refresh(dish)
            
            # Add a couple of random reviews
            reviews = [
                "Absolutely delicious! Tastes like home.",
                "Authentic flavors and great packaging.",
                "Quality ingredients used, highly recommend!",
                "Great portion size and very fresh."
            ]
            for _ in range(2):
                review = Review(
                    user_id=1, # Default to first user
                    dish_id=dish.id,
                    rating=random.uniform(4.0, 5.0),
                    comment=random.choice(reviews)
                )
                db.add(review)
        elif existing.image_url is None:
            existing.image_url = image_url
            db.add(existing)
    
    db.commit()
    print(f"Verified dishes and added reviews for chef_id {chef_id}.")

if __name__ == "__main__":
    seed_data()
