from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, FileField
from wtforms.validators import DataRequired

class ListingPostForm(FlaskForm):
    listing_type = StringField('Listing Type',validators=[DataRequired()])
    listing_name = StringField('Listing Name',validators=[DataRequired()])
    amount_land = StringField('Amount Land',validators=[DataRequired()])
    short_description = StringField('Shore Description',validators=[DataRequired()])
    country = StringField('Country',validators=[DataRequired()])
    state = StringField('State',validators=[DataRequired()])
    city = StringField('City',validators=[DataRequired()])
    postal_code = StringField('Postal Code',validators=[DataRequired()])
    street = StringField('Street',validators=[DataRequired()])
    longitude = StringField('Longitude',validators=[DataRequired()])
    latitude = StringField('Latitude',validators=[DataRequired()])
    thumbnail_image =  FileField('Thumbnail Image',validators=[DataRequired()])
    gallery_image =  FileField('Gallery Image',validators=[DataRequired()])
    amenities = StringField('Amenities',validators=[DataRequired()])
    listing_description = StringField('Listing Description',validators=[DataRequired()])
    total_floor = StringField('Total Floor',validators=[DataRequired()])
    total_room = StringField('Total Room',validators=[DataRequired()])
    room_area = StringField('Room Area',validators=[DataRequired()])
    room_name = StringField('Room Name',validators=[DataRequired()])
    room_thumbnail_image =  FileField('Room Thumbnail Image',validators=[DataRequired()])
    room_price = StringField('Room Price',validators=[DataRequired()])
    discount = StringField('Discount',validators=[DataRequired()])
    additional_info = StringField('Additional Info',validators=[DataRequired()])
    submit = SubmitField("Post")