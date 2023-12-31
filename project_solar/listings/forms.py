from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, FileField, RadioField, TextAreaField, MultipleFileField
from wtforms.validators import DataRequired
from flask_wtf.file import FileAllowed, FileRequired

class ListingPostForm(FlaskForm):
    listing_type = StringField('Listing Type')
    listing_name = StringField('Listing Name')
    amount_land = RadioField('amount_land', choices = [('1','1'), ('2','2'), ('3', '3')])
    short_description = StringField('Short Description')
    country = StringField('Country')
    state = StringField('State')
    city = StringField('City')
    postal_code = StringField('Postal Code')
    street = StringField('Street')
    longitude = StringField('Longitude')
    latitude = StringField('Latitude')
    submit = SubmitField("Add Listing")

class ListingSecondPostForm(FlaskForm):
    amenities = StringField('Amenities')
    listing_description = StringField('Listing Description')
    total_floor = StringField('Total Floor')
    total_room = StringField('Total Room')
    room_area = StringField('Room Area')
    room_name = StringField('Room Name')
    room_price = StringField('Room Price')
    discount = StringField('Discount')
    additional_info = StringField('Additional Info')
    submit = SubmitField("Add Listing")

class ListingPictureForm(FlaskForm):
    thumbnail_image =  FileField('Thumbnail Image', validators=[FileAllowed(['jpg', 'jpeg', 'png'])])
    gallery_images =  FileField(validators=[FileRequired()])
    submit = SubmitField("POST")

#gallery_image =  MultipleFileField('Gallery Image')