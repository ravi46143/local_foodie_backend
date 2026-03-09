from pydantic import BaseModel, EmailStr, Field
from typing import List, Optional
from datetime import datetime

# -----------------------------
# User Schemas
# -----------------------------
class CustomerRegister(BaseModel):
    full_name: str = Field(..., min_length=3)
    email: EmailStr
    phone: str = Field(..., min_length=10, max_length=15)
    password: str = Field(..., min_length=6)
    confirm_password: str

class CustomerResponse(BaseModel):
    id: int
    full_name: str
    email: EmailStr
    phone: str
    role: str

    class Config:
        from_attributes = True

class CustomerLogin(BaseModel):
    email: EmailStr
    password: str

class LoginResponse(BaseModel):
    message: str
    user_id: int
    full_name: str
    email: EmailStr
    phone: str
    role: str
    access_token: str
    token_type: str
    chef_id: Optional[int] = None

# -----------------------------
# Dish Schemas
# -----------------------------
class DishBase(BaseModel):
    name: str
    price: float
    is_veg: bool = True
    category: Optional[str] = None
    image_url: Optional[str] = None
    tag: Optional[str] = None
    description: Optional[str] = None
    cuisine: Optional[str] = None
    food_type: Optional[str] = None
    is_available: bool = True
    prep_time: str = "15m"

class DishResponse(DishBase):
    id: int
    chef_id: int
    rating: float

    class Config:
        from_attributes = True

# -----------------------------
# Chef Schemas
# -----------------------------
class ChefBase(BaseModel):
    name: str
    cuisines: Optional[str] = None
    delivery_time: Optional[str] = None
    is_online: bool = True
    image_url: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    address: Optional[str] = None
    bio: Optional[str] = None
    kitchen_name: Optional[str] = None
    experience: Optional[str] = None
    daily_meals: Optional[str] = None
    cuisine_type: Optional[str] = None
    food_category: Optional[str] = None

class ChefResponse(ChefBase):
    id: int
    rating: float
    dishes: List[DishResponse] = []

    class Config:
        from_attributes = True

class ChefOnboard(BaseModel):
    full_name: str = Field(..., min_length=3)
    email: EmailStr
    phone: str = Field(..., min_length=10, max_length=15)
    password: str = Field(..., min_length=6)
    confirm_password: str
    kitchen_name: str
    food_category: str
    cuisine_type: str
    experience: str
    daily_meals: str
    address: str
    latitude: float
    longitude: float
    image_url: Optional[str] = None

class ChefLogin(BaseModel):
    email: EmailStr
    password: str

class ChefLoginResponse(BaseModel):
    message: str
    chef_id: int
    full_name: str
    email: EmailStr
    phone: str
    address: Optional[str] = None
    access_token: str
    token_type: str

class ChefDashboardStats(BaseModel):
    today_orders: int
    today_earnings: float
    total_earnings: float
    active_dishes: int
    rating: float
    review_count: int
    is_online: bool

class OrderStatusUpdate(BaseModel):
    status: str

class OrderRatingRequest(BaseModel):
    rating: float
    comment: Optional[str] = None

# -----------------------------
# Order Schemas
# -----------------------------
class OrderItemBase(BaseModel):
    dish_id: int
    quantity: int

class OrderItemResponse(OrderItemBase):
    id: int
    price: float

    class Config:
        from_attributes = True

class OrderCreate(BaseModel):
    chef_id: int
    items: List[OrderItemBase]

class OrderResponse(BaseModel):
    id: int
    status: str
    total_amount: float
    created_at: datetime
    customer_rating: Optional[float] = None
    customer_note: Optional[str] = None
    items: List[OrderItemResponse]

    class Config:
        from_attributes = True

# -----------------------------
# Address Schemas
# -----------------------------
class AddressBase(BaseModel):
    label: str
    address_line: str
    landmark: Optional[str] = None
    area: Optional[str] = None
    city: str
    state: Optional[str] = None
    pincode: Optional[str] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None

class AddressCreate(AddressBase):
    user_id: int

class AddressResponse(AddressBase):
    id: int

    class Config:
        from_attributes = True

# -----------------------------
# Review Schemas
# -----------------------------
class ReviewBase(BaseModel):
    rating: float
    comment: Optional[str] = None

class ReviewCreate(ReviewBase):
    dish_id: int

class ReviewResponse(ReviewBase):
    id: int
    user_id: int
    dish_id: int
    created_at: datetime
    full_name: str # From User relationship
    dish_name: Optional[str] = None

    class Config:
        from_attributes = True

# -----------------------------
# Image Upload Schema
# -----------------------------
class ImageResponse(BaseModel):
    image_url: str
    message: str

# -----------------------------
# Wallet & Transaction
# -----------------------------
class TransactionResponse(BaseModel):
    id: int
    amount: float
    type: str
    description: str
    timestamp: datetime

    class Config:
        from_attributes = True

class WalletResponse(BaseModel):
    balance: float
    transactions: List[TransactionResponse] = []

    class Config:
        from_attributes = True

# -----------------------------
# Forgot Password Schemas
# -----------------------------
class ForgotPasswordRequest(BaseModel):
    email: EmailStr

class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp: str

class ResetPasswordRequest(BaseModel):
    email: EmailStr
    otp: str
    new_password: str = Field(..., min_length=6)

# -----------------------------
# Profile Update Schemas
# -----------------------------
class UpdateCustomerProfileRequest(BaseModel):
    user_id: int
    full_name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[EmailStr] = None

class UpdateChefProfileRequest(BaseModel):
    chef_id: int
    full_name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[EmailStr] = None
    kitchen_name: Optional[str] = None
    address: Optional[str] = None
    bio: Optional[str] = None
    image_url: Optional[str] = None