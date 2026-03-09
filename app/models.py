from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    Boolean,
    DateTime,
    Text,
    Enum,
    ForeignKey
)
from sqlalchemy.orm import relationship
from datetime import datetime
from .database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(100), nullable=False)
    email = Column(String(100), unique=True, index=True, nullable=False)
    phone = Column(String(15), unique=True, index=True, nullable=False)
    password = Column(String(255), nullable=False)
    role = Column(String(50), default="customer")
    created_at = Column(DateTime, default=datetime.utcnow)
    
    otp_code = Column(String(6), nullable=True)
    otp_expiry = Column(DateTime, nullable=True)

    # Relationships
    wallet = relationship("Wallet", back_populates="user", uselist=False)
    orders = relationship("Order", back_populates="customer")
    addresses = relationship("Address", back_populates="user")

class Chef(Base):
    __tablename__ = "chefs"
    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String(100), nullable=False)
    email = Column(String(100), unique=True, index=True, nullable=False)
    phone = Column(String(15), unique=True, index=True, nullable=False)
    password = Column(String(255), nullable=False)
    role = Column(String(50), default="chef")
    name = Column(String(100), nullable=False)
    rating = Column(Float, default=0.0)
    cuisines = Column(String(255))
    delivery_time = Column(String(50))
    is_online = Column(Boolean, default=True)
    image_url = Column(String(255))
    latitude = Column(Float, nullable=True)
    longitude = Column(Float, nullable=True)
    address = Column(String(255), nullable=True)
    bio = Column(Text, nullable=True)
    status = Column(Enum("online", "offline"), default="offline")
    # New Onboarding fields
    kitchen_name = Column(String(100), nullable=False)
    experience = Column(String(50), nullable=False)
    daily_meals = Column(String(50), nullable=False)
    cuisine_type = Column(String(100), nullable=False)
    food_category = Column(String(100), nullable=False)

    # Relationships
    dishes = relationship("Dish", back_populates="chef")

class Dish(Base):
    __tablename__ = "dishes"

    id = Column(Integer, primary_key=True, index=True)
    chef_id = Column(Integer, ForeignKey("chefs.id"))
    name = Column(String(100), nullable=False)
    price = Column(Float, nullable=False)
    rating = Column(Float, default=0.0)
    is_veg = Column(Boolean, default=True)
    category = Column(String(50))
    image_url = Column(String(255))
    tag = Column(String(50))
    description = Column(Text, nullable=False)
    cuisine = Column(String(50), nullable=False)
    food_type = Column(String(50), nullable=False)
    is_available = Column(Boolean, default=True)
    prep_time = Column(String(20), default="15m")

    # Relationships
    chef = relationship("Chef", back_populates="dishes")
    reviews = relationship("Review", back_populates="dish")

class Review(Base):
    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    dish_id = Column(Integer, ForeignKey("dishes.id"))
    order_id = Column(Integer, ForeignKey("orders.id"), nullable=True)
    rating = Column(Float, nullable=False)
    comment = Column(Text)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    user = relationship("User")
    dish = relationship("Dish", back_populates="reviews")

class Order(Base):
    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    chef_id = Column(Integer, ForeignKey("chefs.id"))
    status = Column(String(50), default="pending")
    total_amount = Column(Float, nullable=False)
    customer_rating = Column(Float, nullable=True)
    customer_note = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    customer = relationship("User", back_populates="orders")
    items = relationship("OrderItem", back_populates="order")

class OrderItem(Base):
    __tablename__ = "order_items"

    id = Column(Integer, primary_key=True, index=True)
    order_id = Column(Integer, ForeignKey("orders.id"))
    dish_id = Column(Integer, ForeignKey("dishes.id"))
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)

    # Relationships
    order = relationship("Order", back_populates="items")
    dish = relationship("Dish")

class Address(Base):
    __tablename__ = "addresses"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    label = Column(String(50))  # Home, Work, etc.
    address_line = Column(Text, nullable=False)
    landmark = Column(String(255), nullable=True)
    area = Column(String(100), nullable=True)
    city = Column(String(100))
    state = Column(String(100), nullable=True)
    pincode = Column(String(20), nullable=True)
    latitude = Column(Float, nullable=True)
    longitude = Column(Float, nullable=True)

    # Relationships
    user = relationship("User", back_populates="addresses")

class Wallet(Base):
    __tablename__ = "wallets"

    user_id = Column(Integer, ForeignKey("users.id"), primary_key=True)
    balance = Column(Float, default=0.0)

    # Relationships
    user = relationship("User", back_populates="wallet")
    transactions = relationship("Transaction", back_populates="wallet")

class Transaction(Base):
    __tablename__ = "transactions"

    id = Column(Integer, primary_key=True, index=True)
    wallet_id = Column(Integer, ForeignKey("wallets.user_id"))
    amount = Column(Float, nullable=False)
    type = Column(String(20))  # credit, debit
    description = Column(String(255))
    timestamp = Column(DateTime, default=datetime.utcnow)

    # Relationships
    wallet = relationship("Wallet", back_populates="transactions")

class PasswordReset(Base):
    __tablename__ = "password_resets"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(100), index=True, nullable=False)
    otp = Column(String(6), nullable=False)
    expires_at = Column(DateTime, nullable=False)
    is_verified = Column(Boolean, default=False)