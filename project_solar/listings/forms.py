from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, FileField, RadioField, TextAreaField
from wtforms.validators import DataRequired

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
    amenities = StringField('Amenities',validators=[DataRequired()])
    listing_description = TextAreaField('Listing Description',validators=[DataRequired()])
    total_floor = StringField('Total Floor',validators=[DataRequired()])
    total_room = StringField('Total Room',validators=[DataRequired()])
    room_area = StringField('Room Area',validators=[DataRequired()])
    room_name = StringField('Room Name',validators=[DataRequired()])
    room_price = StringField('Room Price',validators=[DataRequired()])
    discount = StringField('Discount',validators=[DataRequired()])
    additional_info = StringField('Additional Info',validators=[DataRequired()])
    submit = SubmitField("Post")

class ListingPictureForm(FlaskForm):
    thumbnail_image =  FileField('Thumbnail Image',validators=[DataRequired()])
    gallery_image =  FileField('Gallery Image',validators=[DataRequired()])
    room_thumbnail_image =  FileField('Room Thumbnail Image',validators=[DataRequired()])
    submit = SubmitField("Post")