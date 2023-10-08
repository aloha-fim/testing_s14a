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
    listing_posts = db.relationship('ListingPost',backref='author',lazy=True)
    listing_second_posts = db.relationship('ListingSecondPost',backref='author',lazy=True)
    listing_picture_posts = db.relationship('ListingPictures',backref='author',lazy=True)

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
    listing_type = db.Column(db.String(140))
    listing_name = db.Column(db.String(140))
    amount_land = db.Column(db.String(140))
    short_description = db.Column(db.String(140))
    country = db.Column(db.String(140))
    state = db.Column(db.String(140))
    city = db.Column(db.String(140))
    postal_code = db.Column(db.String(140))
    street = db.Column(db.String(140))
    longitude = db.Column(db.String(140))
    latitude = db.Column(db.String(140))

    listing_second_post = db.relationship('ListingSecondPost',back_populates="listing_main_post")
    listing_picture_post = db.relationship('ListingPictures',back_populates="listing_main_post")

    def __init__(self,listing_type,listing_name,amount_land,short_description,country,state,city,postal_code,street,longitude,latitude,user_id):
        self.listing_type = listing_type
        self.listing_name = listing_name
        self.amount_land = amount_land
        self.short_description = short_description
        self.country = country
        self.state = state
        self.city = city
        self.postal_code = postal_code
        self.street = street
        self.longitude = longitude
        self.latitude = latitude
        self.user_id = user_id

    def __repr__(self):
        return f"Post ID: {self.id} -- Date: {self.date}"


class ListingSecondPost(db.Model):
    
    users = db.relationship(User)
    listing_main_post = db.relationship('ListingPost',back_populates="listing_second_post")

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'),nullable=False)
    listing_id = db.Column(db.Integer,db.ForeignKey('listing_post.id'),primary_key=True, autoincrement=True)
    

    date = db.Column(db.DateTime,nullable=False,default=datetime.utcnow)
    amenities = db.Column(db.String(140))
    listing_description = db.Column(db.String(140))
    total_floor = db.Column(db.String(140))
    total_room = db.Column(db.String(140))
    room_area = db.Column(db.String(140))
    room_name = db.Column(db.String(140))
    room_price = db.Column(db.String(140))
    discount = db.Column(db.String(140))
    additional_info = db.Column(db.String(140))

    def __init__(self,amenities,listing_description,total_floor,total_room,room_area,room_name,room_price,discount,additional_info,user_id):
        self.amenities = amenities
        self.listing_description = listing_description
        self.total_floor = total_floor
        self.total_room = total_room
        self.room_area = room_area
        self.room_name = room_name
        self.room_price = room_price
        self.discount = discount
        self.additional_info = additional_info
        self.user_id = user_id

    def __repr__(self):
        return f"Post ID: {self.id} -- Date: {self.date}"

class ListingPictures(db.Model):
    
    users = db.relationship(User)
    listing_main_post = db.relationship('ListingPost',back_populates="listing_picture_post")

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer,db.ForeignKey('users.id'),nullable=False)
    listing_id = db.Column(db.Integer,db.ForeignKey('listing_post.id'),primary_key=True, autoincrement=True)

    date = db.Column(db.DateTime,nullable=False,default=datetime.utcnow)
    thumbnail_image = db.Column(db.String(140))
    gallery_image = db.Column(db.String(140))

    def __init__(self,thumbnail_image,gallery_image,user_id):
        self.thumbnail_image = thumbnail_image
        self.gallery_image = gallery_image
        self.user_id = user_id

    def __repr__(self):
        return f"Post ID: {self.id} -- Date: {self.date}"