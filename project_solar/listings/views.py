from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import ListingPost
from project_solar.listings.forms import ListingPostForm
import os



listings = Blueprint('listings',__name__)

@listings.route('/create_creation')
def create_listing():
    return render_template('join-us.html')

@listings.route('/add_listing',methods=['GET','POST'])
@login_required
def add_listing():

    form = ListingPostForm()

    if request.method == 'POST':
        for f in request.files.getlist('file'):
            f.save(os.path.join(os.path.join(listings.root_path, 'upload'), f.filename))

    if form.validate_on_submit():
        listing = ListingPost(user_id=current_user.id,
                    listing_type=form.listing_type.data,
                    listing_name = form.listing_name.data,
                    amount_land = form.amount_land.data,
                    short_description = form.short_description.data,
                    country = form.country.data,
                    state = form.state.data,
                    city = form.city.data,
                    postal_code = form.postal_code.data,
                    street = form.street.data,
                    longitude = form.longitude.data,
                    latitude = form.latitude.data,
                    thumbnail_image = form.thumbnail_image.data,
                    gallery_image = form.gallery_image.data,
                    amenities = form.amenities.data,
                    listing_description = form.listing_description.data,
                    total_floor = form.total_floor.data,
                    total_room = form.total_room.data,
                    room_area = form.room_area.data,
                    room_name = form.room_name.data,
                    room_thumbnail_image = form.room_thumbnail_image.data,
                    room_price = form.room_price.data,   
                    discount = form.discount.data,                                                                                                                   
                    additional_info=form.additional_info.data)
        
        db.session.add(listing)
        db.session.commit()
        flash('Thanks for Listing!')
        return redirect(url_for('core.start'))
    
    return render_template('add-listing.html',form=form)