from project_solar import db,login_manager
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import UserMixin
from datetime import datetime

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)

class User(db.Model,UserMixin):
    
    __tablename__ = 'users'

    id = db.Column(db.Integer,primary_key=True)
    profile_image = db.Column(db.String(64),nullable=False, default='default.png')
    email = db.Column(db.String(64),unique=True,index=True)
    username = db.Column(db.String(64),unique=True,index=True)
    password_hash = db.Column(db.String(128))

    posts = db.relationship('SolarPost',backref='author',lazy=True)

    def __init__(self,email,username,password):
        self.email = email
        self.username = username
        self.password_hash = generate_password_hash(password)

    def check_password(self,password):
        return check_password_hash(self.password_hash,password)
    
    def __repr__(self):
        return f"Username {self.username}"


class SolarPost(db.Model):
    
    users = db.relationship(User)

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'),nullable=False)

    date = db.Column(db.DateTime,nullable=False,default=datetime.utcnow)
    title = db.Column(db.String(140),nullable=False)
    text = db.Column(db.Text,nullable=False)

    def __init__(self,title,text,user_id):
        self.title = title
        self.text = text
        self.user_id = user_id

    def __repr__(self):
        return f"Post ID: {self.id} -- Date: {self.date} -- {self.title}"
    

class ListingPost(db.Model):
    
    users = db.relationship(User)

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'),nullable=False)

    date = db.Column(db.DateTime,nullable=False,default=datetime.utcnow)
    listing_type = db.Column(db.String(140),nullable=False)
    listing_name = db.Column(db.String(140),nullable=False)
    amount_land = db.Column(db.String(140),nullable=False)
    short_description = db.Column(db.String(140),nullable=False)
    country = db.Column(db.String(140),nullable=False)
    state = db.Column(db.String(140),nullable=False)
    city = db.Column(db.String(140),nullable=False)
    postal_code = db.Column(db.String(140),nullable=False)
    street = db.Column(db.String(140),nullable=False)
    longitude = db.Column(db.String(140),nullable=False)
    latitude = db.Column(db.String(140),nullable=False)
    thumbnail_image = db.Column(db.String(140),nullable=False)
    gallery_image = db.Column(db.String(140),nullable=False)
    amenities = db.Column(db.String(140),nullable=False)
    listing_description = db.Column(db.String(140),nullable=False)
    total_floor = db.Column(db.String(140),nullable=False)
    total_room = db.Column(db.String(140),nullable=False)
    room_area = db.Column(db.String(140),nullable=False)
    room_name = db.Column(db.String(140),nullable=False)
    room_thumbnail_image = db.Column(db.String(140),nullable=False)
    room_price = db.Column(db.String(140),nullable=False)
    discount = db.Column(db.String(140),nullable=False)
    additional_info = db.Column(db.String(140),nullable=False)

    def __init__(self,listing_type,listing_name,user_id):
        self.listing_type = listing_type
        self.listing_name = listing_name
        self.user_id = user_id

    def __repr__(self):
        return f"Post ID: {self.id} -- Date: {self.date} -- {self.listing_name}"
    