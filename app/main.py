import math
import os
import shutil
from fastapi import HTTPException
from sqlalchemy.orm import Session
from fastapi import Depends
from fastapi import FastAPI, Depends, HTTPException, status, Query, File, UploadFile
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session
from typing import List, Optional
from .database import engine, SessionLocal, get_db
from .models import Base, User, Chef, Dish, Order, OrderItem, Wallet, Transaction, Review, Address, PasswordReset
from .schemas import (
    CustomerRegister, CustomerResponse, CustomerLogin, LoginResponse,
    ChefResponse, DishResponse, OrderCreate, OrderResponse, WalletResponse,
    ReviewCreate, ReviewResponse, ChefOnboard, ChefDashboardStats, ImageResponse,
    OrderStatusUpdate, OrderRatingRequest, ChefLogin, ChefLoginResponse, AddressCreate, AddressResponse,
    ForgotPasswordRequest, VerifyOTPRequest, ResetPasswordRequest,
    UpdateCustomerProfileRequest, UpdateChefProfileRequest
)
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime, timedelta
from jose import JWTError, jwt
from passlib.context import CryptContext
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig
import random
from datetime import datetime, timedelta



conf = ConnectionConfig(
    MAIL_USERNAME="punaganiravi@gmail.com",
    MAIL_PASSWORD="wcmj orqe csqu osfx",
    MAIL_FROM="punaganiravi@gmail.com",
    MAIL_PORT=587,
    MAIL_SERVER="smtp.gmail.com",
    MAIL_STARTTLS=True,
    MAIL_SSL_TLS=False,
    USE_CREDENTIALS=True
)


# -------------------------
# Utilities
# -------------------------
def calculate_distance(lat1, lon1, lat2, lon2):
    """Haversine formula to calculate distance between two points in km"""
    if lat1 is None or lon1 is None or lat2 is None or lon2 is None:
        return 999.0
    R = 6371.0  # Earth radius in km
    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2)**2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    return R * c

# -------------------------
# App Initialization
# -------------------------
app = FastAPI(title="Local Foodies API")

# Add CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create tables
Base.metadata.create_all(bind=engine)

# Ensure uploads directory exists
UPLOAD_DIR = "uploads"
if not os.path.exists(UPLOAD_DIR):
    os.makedirs(UPLOAD_DIR)

app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")

# -------------------------
# JWT Configuration
# -------------------------
SECRET_KEY = "CHANGE_THIS_TO_A_LONG_RANDOM_SECRET_KEY"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60

# -------------------------
# Database Dependency
# -------------------------
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# -------------------------
# Auth APIs
# -------------------------
@app.post("/customer_register", response_model=CustomerResponse)
def register_customer(user: CustomerRegister, db: Session = Depends(get_db)):
    if user.password != user.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")
    if db.query(User).filter(User.email == user.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")
    if db.query(User).filter(User.phone == user.phone).first():
        raise HTTPException(status_code=400, detail="Phone number already registered")

    new_user = User(
        full_name=user.full_name,
        email=user.email,
        phone=user.phone,
        password=user.password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Initialize wallet
    wallet = Wallet(user_id=new_user.id, balance=0.0)
    db.add(wallet)
    db.commit()

    return new_user

@app.post("/customer_login", response_model=LoginResponse)
def login_customer(user: CustomerLogin, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.email == user.email).first()
    if not db_user or user.password != db_user.password:
        raise HTTPException(status_code=400, detail="Invalid email or password")

    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    payload = {"sub": db_user.email, "role": db_user.role, "exp": expire}
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

    chef = db.query(Chef).filter(Chef.email == db_user.email).first()
    chef_id = chef.id if chef else None

    return {
        "message": "Login successful",
        "user_id": db_user.id,
        "full_name": db_user.full_name,
        "email": db_user.email,
        "phone": db_user.phone,
        "role": db_user.role,
        "access_token": token,
        "token_type": "bearer",
        "chef_id": chef_id
    }

@app.post("/forgot_password")
async def forgot_password(email: str, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="Email not registered")

    # Generate proper 6-digit OTP
    otp = f"{random.randint(0, 999999):06d}"

    expiry = datetime.utcnow() + timedelta(minutes=5)

    user.otp_code = otp
    user.otp_expiry = expiry
    db.commit()

    message = MessageSchema(
        subject="Local Foodies Password Reset OTP",
        recipients=[email],
        body=f"Your OTP is: {otp}\nThis OTP will expire in 5 minutes.",
        subtype="plain"
    )

    fm = FastMail(conf)
    await fm.send_message(message)

    return {"message": "OTP sent successfully"}



@app.post("/verify_otp")
def verify_otp(email: str, otp: str, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    if not user.otp_code:
        raise HTTPException(status_code=400, detail="OTP not generated")

    if user.otp_code != otp:
        raise HTTPException(status_code=400, detail="Invalid OTP")

    if not user.otp_expiry or datetime.utcnow() > user.otp_expiry:
        raise HTTPException(status_code=400, detail="OTP expired")

    if datetime.utcnow() > user.otp_expiry:
        raise HTTPException(status_code=400, detail="OTP expired")

    return {"message": "OTP verified successfully"}


@app.post("/reset_password")
def reset_password(email: str, new_password: str, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == email).first()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.password = new_password
    user.otp_code = None
    user.otp_expiry = None

    db.commit()

    return {"message": "Password reset successful"}


# -------------------------
# Chef & Dish APIs
# -------------------------
@app.get("/chefs", response_model=List[ChefResponse])
def get_chefs(db: Session = Depends(get_db)):
    """Get all online chefs for the customer dashboard."""
    return db.query(Chef).filter(Chef.is_online == True).all()

@app.get("/chefs/{chef_id}", response_model=ChefResponse)
def get_chef_details(chef_id: int, db: Session = Depends(get_db)):
    chef = db.query(Chef).filter(Chef.id == chef_id).first()
    if not chef:
        raise HTTPException(status_code=404, detail="Chef not found")
    return chef

@app.get("/dishes/category/{category}", response_model=List[DishResponse])
def get_dishes_by_category(category: str, db: Session = Depends(get_db)):
    return db.query(Dish).filter(Dish.category == category).all()

@app.get("/dishes", response_model=List[DishResponse])
def get_all_dishes(db: Session = Depends(get_db)):
    return db.query(Dish).all()

@app.get("/dishes/chef/{chef_id}", response_model=List[DishResponse])
def get_dishes_by_chef(chef_id: int, db: Session = Depends(get_db)):
    """Get all dishes for a specific chef — used by both chef menu screen and customer view."""
    return db.query(Dish).filter(Dish.chef_id == chef_id).all()


@app.post("/dishes", response_model=DishResponse)
def create_dish(dish: DishResponse, db: Session = Depends(get_db)):
    # Note: Use a dedicated schema for creation if needed, 
    # but for simplicity reusing DishResponse-like data
    new_dish = Dish(
        chef_id=dish.chef_id,
        name=dish.name,
        price=dish.price,
        rating=dish.rating,
        is_veg=dish.is_veg,
        category=dish.category,
        image_url=dish.image_url,
        tag=dish.tag,
        description=dish.description,
        cuisine=dish.cuisine,
        food_type=dish.food_type
    )
    db.add(new_dish)
    db.commit()
    db.refresh(new_dish)
    return new_dish

@app.post("/chefs/onboard", response_model=ChefResponse)
def onboard_chef(data: ChefOnboard, db: Session = Depends(get_db)):
    if data.password != data.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")
    
    # Check duplicate email/phone in chefs table
    if db.query(Chef).filter(Chef.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email already registered as chef")
    if db.query(Chef).filter(Chef.phone == data.phone).first():
        raise HTTPException(status_code=400, detail="Phone number already registered as chef")

    new_chef = Chef(
        full_name=data.full_name,
        email=data.email,
        phone=data.phone,
        password=data.password,
        name=data.kitchen_name,
        kitchen_name=data.kitchen_name,
        food_category=data.food_category,
        cuisine_type=data.cuisine_type,
        experience=data.experience,
        daily_meals=data.daily_meals,
        address=data.address,
        latitude=data.latitude,
        longitude=data.longitude,
        image_url=data.image_url,
        is_online=True
    )
    db.add(new_chef)
    db.commit()
    db.refresh(new_chef)
    return new_chef

@app.post("/chefs/login", response_model=ChefLoginResponse)
def login_chef(user: ChefLogin, db: Session = Depends(get_db)):
    db_chef = db.query(Chef).filter(Chef.email == user.email).first()
    if not db_chef or user.password != db_chef.password:
        raise HTTPException(status_code=400, detail="Invalid email or password")

    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    payload = {"sub": db_chef.email, "role": "chef", "exp": expire}
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)

    return {
        "message": "Login successful",
        "chef_id": db_chef.id,
        "full_name": db_chef.full_name,
        "email": db_chef.email,
        "phone": db_chef.phone,
        "address": db_chef.address,
        "access_token": token,
        "token_type": "bearer"
    }

@app.get("/chefs/dashboard/{chef_id}", response_model=ChefDashboardStats)
def get_chef_stats(chef_id: int, db: Session = Depends(get_db)):
    # Today's orders
    today = datetime.utcnow().date()
    orders = db.query(Order).filter(
        Order.chef_id == chef_id,
        Order.created_at >= datetime.combine(today, datetime.min.time())
    ).all()
    
    today_orders = len(orders)
    today_earnings = sum([o.total_amount for o in orders if o.status != "cancelled"])
    
    # Total earnings
    all_orders = db.query(Order).filter(Order.chef_id == chef_id, Order.status != "cancelled").all()
    total_earnings = sum([o.total_amount for o in all_orders])
    
    # Active dishes
    active_dishes = db.query(Dish).filter(Dish.chef_id == chef_id).count()
    
    # Rating and reviews
    chef = db.query(Chef).filter(Chef.id == chef_id).first()
    rating = chef.rating if chef else 0.0
    
    # Count reviews for all dishes of this chef
    dish_ids = [d.id for d in db.query(Dish.id).filter(Dish.chef_id == chef_id).all()]
    review_count = db.query(Review).filter(Review.dish_id.in_(dish_ids)).count()
    
    return {
        "today_orders": today_orders,
        "today_earnings": today_earnings,
        "total_earnings": total_earnings,
        "active_dishes": active_dishes,
        "rating": rating,
        "review_count": review_count,
        "is_online": chef.is_online if chef else False
    }

@app.get("/chefs/nearby", response_model=List[ChefResponse])
def get_nearby_chefs(lat: float, lon: float, radius: float = 10.0, db: Session = Depends(get_db)):
    all_chefs = db.query(Chef).filter(Chef.is_online == True).all()
    nearby = []
    for chef in all_chefs:
        dist = calculate_distance(lat, lon, chef.latitude, chef.longitude)
        if dist <= radius:
            nearby.append(chef)
    return nearby

@app.get("/dishes/{dish_id}/reviews", response_model=List[ReviewResponse])
def get_dish_reviews(dish_id: int, db: Session = Depends(get_db)):
    reviews = db.query(Review).filter(Review.dish_id == dish_id).all()
    results = []
    for r in reviews:
        results.append({
            "id": r.id,
            "user_id": r.user_id,
            "dish_id": r.dish_id,
            "rating": r.rating,
            "comment": r.comment,
            "created_at": r.created_at,
            "full_name": r.user.full_name
        })
    return results

@app.post("/dishes/reviews", response_model=ReviewResponse)
def create_review(review: ReviewCreate, user_id: int, db: Session = Depends(get_db)):
    db_review = Review(
        user_id=user_id,
        dish_id=review.dish_id,
        rating=review.rating,
        comment=review.comment
    )
    db.add(db_review)
    db.commit()
    db.refresh(db_review)
    
    # Update dish rating
    dish = db.query(Dish).filter(Dish.id == review.dish_id).first()
    if dish:
        all_reviews = db.query(Review).filter(Review.dish_id == dish.id).all()
        avg_rating = sum([r.rating for r in all_reviews]) / len(all_reviews)
        dish.rating = avg_rating
        db.commit()

    return {
        "id": db_review.id,
        "user_id": db_review.user_id,
        "dish_id": db_review.dish_id,
        "rating": db_review.rating,
        "comment": db_review.comment,
        "created_at": db_review.created_at,
        "full_name": db_review.user.full_name
    }

# Dish creation is handled above at line 133

# -------------------------
# Order APIs
# -------------------------
@app.post("/orders", response_model=OrderResponse)
def create_order(order: OrderCreate, current_user_id: int, db: Session = Depends(get_db)):
    total = 0.0
    db_items = []

    for item in order.items:
        dish = db.query(Dish).filter(Dish.id == item.dish_id).first()
        if not dish:
            raise HTTPException(status_code=404, detail=f"Dish {item.dish_id} not found")
        total += dish.price * item.quantity
        db_items.append(OrderItem(dish_id=item.dish_id, quantity=item.quantity, price=dish.price))

    # Create order first (COD - no wallet check required)
    new_order = Order(
        user_id=current_user_id,
        chef_id=order.chef_id,
        total_amount=total,
        status="pending"
    )
    db.add(new_order)
    db.commit()
    db.refresh(new_order)

    for db_item in db_items:
        db_item.order_id = new_order.id
        db.add(db_item)

    db.commit()
    db.refresh(new_order)
    return new_order

@app.get("/orders/history", response_model=List[OrderResponse])
def get_order_history(user_id: int, db: Session = Depends(get_db)):
    return db.query(Order).filter(Order.user_id == user_id).order_by(Order.created_at.desc()).all()

@app.get("/orders/chef/{chef_id}", response_model=List[OrderResponse])
def get_chef_orders(chef_id: int, db: Session = Depends(get_db)):
    return db.query(Order).filter(Order.chef_id == chef_id).order_by(Order.created_at.desc()).all()

@app.patch("/orders/{order_id}/status", response_model=OrderResponse)
def update_order_status(order_id: int, data: OrderStatusUpdate, db: Session = Depends(get_db)):
    db_order = db.query(Order).filter(Order.id == order_id).first()
    if not db_order:
        raise HTTPException(status_code=404, detail="Order not found")
    
    db_order.status = data.status.lower()
    db.commit()
    db.refresh(db_order)
    return db_order

@app.post("/orders/{order_id}/rate", response_model=OrderResponse)
def rate_order(order_id: int, data: OrderRatingRequest, db: Session = Depends(get_db)):
    db_order = db.query(Order).filter(Order.id == order_id).first()
    if not db_order:
        raise HTTPException(status_code=404, detail="Order not found")

    # Check if order is in a rateable state
    if db_order.status not in ["delivered", "DELIVERED"]:
        raise HTTPException(status_code=400, detail="Only delivered orders can be rated")

    db_order.customer_rating = data.rating
    db_order.customer_note = data.comment

    # Get all items in this order
    order_items = db.query(OrderItem).filter(OrderItem.order_id == order_id).all()

    affected_chef_ids = set()

    for item in order_items:
        # Avoid duplicate reviews: one review per user per dish per order
        existing_review = db.query(Review).filter(
            Review.user_id == db_order.user_id,
            Review.dish_id == item.dish_id,
            Review.order_id == order_id
        ).first()

        if existing_review:
            # Update existing review
            existing_review.rating = data.rating
            existing_review.comment = data.comment
        else:
            # Create a new review
            new_review = Review(
                user_id=db_order.user_id,
                dish_id=item.dish_id,
                order_id=order_id,
                rating=data.rating,
                comment=data.comment
            )
            db.add(new_review)

        # Track affected dishes for rating recalculation
        dish = db.query(Dish).filter(Dish.id == item.dish_id).first()
        if dish:
            affected_chef_ids.add(dish.chef_id)

    # Flush so new reviews are visible for aggregation
    db.flush()

    # Recalculate average ratings for all affected dishes and chefs
    for item in order_items:
        dish = db.query(Dish).filter(Dish.id == item.dish_id).first()
        if dish:
            all_dish_reviews = db.query(Review).filter(Review.dish_id == dish.id).all()
            if all_dish_reviews:
                dish.rating = sum(r.rating for r in all_dish_reviews) / len(all_dish_reviews)

    for chef_id in affected_chef_ids:
        chef = db.query(Chef).filter(Chef.id == chef_id).first()
        if chef:
            dish_ids = [d.id for d in db.query(Dish.id).filter(Dish.chef_id == chef_id).all()]
            chef_reviews = db.query(Review).filter(Review.dish_id.in_(dish_ids)).all()
            if chef_reviews:
                chef.rating = sum(r.rating for r in chef_reviews) / len(chef_reviews)

    db.commit()
    db.refresh(db_order)
    return db_order

@app.get("/chefs/{chef_id}/reviews", response_model=List[ReviewResponse])
def get_chef_reviews(chef_id: int, db: Session = Depends(get_db)):
    dish_ids = [d.id for d in db.query(Dish.id).filter(Dish.chef_id == chef_id).all()]
    reviews = db.query(Review).filter(Review.dish_id.in_(dish_ids)).order_by(Review.created_at.desc()).all()
    
    results = []
    for r in reviews:
        # Fetch dish name as well
        dish_name = db.query(Dish.name).filter(Dish.id == r.dish_id).scalar()
        results.append({
            "id": r.id,
            "user_id": r.user_id,
            "dish_id": r.dish_id,
            "rating": r.rating,
            "comment": r.comment,
            "created_at": r.created_at,
            "full_name": r.user.full_name,
            "dish_name": dish_name
        })
    return results

# -------------------------
# Wallet APIs
# -------------------------
@app.get("/wallet/balance", response_model=WalletResponse)
def get_wallet(user_id: int, db: Session = Depends(get_db)):
    wallet = db.query(Wallet).filter(Wallet.user_id == user_id).first()
    if not wallet:
        raise HTTPException(status_code=404, detail="Wallet not found")
    return wallet

# -------------------------
# Address APIs
# -------------------------
@app.get("/addresses/{user_id}", response_model=List[AddressResponse])
def get_addresses(user_id: int, db: Session = Depends(get_db)):
    return db.query(Address).filter(Address.user_id == user_id).all()

@app.post("/addresses", response_model=AddressResponse)
def add_address(address: AddressCreate, db: Session = Depends(get_db)):
    db_address = Address(
        user_id=address.user_id,
        label=address.label,
        address_line=address.address_line,
        landmark=address.landmark,
        area=address.area,
        city=address.city,
        state=address.state,
        pincode=address.pincode,
        latitude=address.latitude,
        longitude=address.longitude
    )
    db.add(db_address)
    db.commit()
    db.refresh(db_address)
    return db_address

# -------------------------
# Image Upload API
# -------------------------
@app.post("/upload", response_model=ImageResponse)
async def upload_image(image: UploadFile = File(...)):
    try:
        filename = f"{datetime.now().strftime('%Y%m%d%H%M%S')}_{image.filename}"
        file_path = os.path.join(UPLOAD_DIR, filename)
        
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(image.file, buffer)
            
        # Replace with your current machine IP (found via ipconfig)
        image_url = f"http://10.164.109.239:8000/uploads/{filename}"
        
        return {"image_url": image_url, "message": "Image uploaded successfully"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Image upload failed: {str(e)}")

# -------------------------
# Profile Update APIs
# -------------------------
@app.put("/update-profile/customer")
def update_customer_profile(data: UpdateCustomerProfileRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == data.user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if data.full_name:
        user.full_name = data.full_name
    if data.phone:
        if db.query(User).filter(User.phone == data.phone, User.id != data.user_id).first():
            raise HTTPException(status_code=400, detail="Phone already in use")
        user.phone = data.phone
    if data.email:
        if db.query(User).filter(User.email == data.email, User.id != data.user_id).first():
            raise HTTPException(status_code=400, detail="Email already in use")
        user.email = data.email
    db.commit()
    db.refresh(user)
    return {"message": "Profile updated successfully", "full_name": user.full_name, "email": user.email, "phone": user.phone}

@app.put("/update-profile/chef")
def update_chef_profile(data: UpdateChefProfileRequest, db: Session = Depends(get_db)):
    chef = db.query(Chef).filter(Chef.id == data.chef_id).first()
    if not chef:
        raise HTTPException(status_code=404, detail="Chef not found")
    if data.full_name:
        chef.full_name = data.full_name
    if data.kitchen_name:
        chef.kitchen_name = data.kitchen_name
        chef.name = data.kitchen_name  # keep name in sync
    if data.phone:
        if db.query(Chef).filter(Chef.phone == data.phone, Chef.id != data.chef_id).first():
            raise HTTPException(status_code=400, detail="Phone already in use")
        chef.phone = data.phone
    if data.email:
        if db.query(Chef).filter(Chef.email == data.email, Chef.id != data.chef_id).first():
            raise HTTPException(status_code=400, detail="Email already in use")
        chef.email = data.email
    if data.address:
        chef.address = data.address
    if data.bio:
        chef.bio = data.bio
    if data.image_url:
        chef.image_url = data.image_url
    if data.is_online is not None:
        chef.is_online = data.is_online
        chef.status = "online" if data.is_online else "offline"
    db.commit()
    db.refresh(chef)
    return {"message": "Chef profile updated successfully", "full_name": chef.full_name, "kitchen_name": chef.kitchen_name, "email": chef.email, "phone": chef.phone}

# -------------------------
# Root Endpoint
# -------------------------
@app.get("/")
def root():
    return {"message": "Local Foodies API Running 🚀"}


@app.put("/update_status")
def update_status(chef_id: int, online: bool, db: Session = Depends(get_db)):
    chef = db.query(Chef).filter(Chef.id == chef_id).first()
    if not chef:
        raise HTTPException(status_code=404, detail="Chef not found")

    chef.is_online = online
    chef.status = "online" if online else "offline"
    db.commit()
    status_str = "online" if online else "offline"
    return {"message": f"Status updated to {status_str}"}

@app.get("/get_status")
def get_status(chef_id: int, db: Session = Depends(get_db)):
    chef = db.query(Chef).filter(Chef.id == chef_id).first()
    if not chef:
        raise HTTPException(status_code=404, detail="Chef not found")

        # Updated to use chef

        # Status is already fetched in chef variable above

    return {
        "chef_id": chef.id,
        "is_online": chef.is_online
    }

from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session
from .database import get_db
from .models import Order, OrderItem, User, Address, Dish


@app.get("/orders/{order_id}")
def get_order_details(order_id: int, db: Session = Depends(get_db)):

    order = db.query(Order).filter(Order.id == order_id).first()

    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    user = db.query(User).filter(User.id == order.user_id).first()
    address = db.query(Address).filter(Address.user_id == user.id).first()

    items = (
        db.query(OrderItem, Dish)
        .join(Dish, OrderItem.dish_id == Dish.id)
        .filter(OrderItem.order_id == order.id)
        .all()
    )

    item_list = []
    for item, dish in items:
        item_list.append({
            "dish_name": dish.name,
            "quantity": item.quantity,
            "price": item.price
        })

    return {
        "order_id": order.id,
        "status": order.status,
        "total_amount": order.total_amount,
        "created_at": order.created_at,

        "customer": {
            "name": user.full_name,
            "phone": user.phone,
            "email": user.email
        },

        "delivery_address": {
            "address_line": address.address_line if address else None,
            "city": address.city if address else None,
            "latitude": address.latitude if address else None,
            "longitude": address.longitude if address else None,
        },

        "items": item_list
    }