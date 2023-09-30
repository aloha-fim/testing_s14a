from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import ListingPost, ListingSecondPost, ListingPictures
from project_solar.listings.forms import ListingPostForm, ListingSecondPostForm, ListingPictureForm
import os



listings = Blueprint('listings',__name__)

@listings.route('/results_list')
def results():
    return render_template('tour-grid.html')

@listings.route('/listing_confirm')
def listing_confirm():
    return render_template('listing-added.html')

@listings.route('/create_creation')
def create_listing():
    return render_template('join-us.html')

@listings.route('/add_listing',methods=['POST', 'GET'])
@login_required
def add_listing():

    form = ListingPostForm()

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
                    latitude = form.latitude.data)
        
        db.session.add(listing)
        db.session.commit()
        flash('Thanks for Listing!')
        return redirect(url_for('listings.second_listing'))
    
    return render_template('add-listing.html',form=form)


@listings.route('/second_listing',methods=['POST', 'GET'])
@login_required
def second_listing():

    form = ListingSecondPostForm()

    if form.validate_on_submit():
        listing = ListingSecondPost(user_id=current_user.id,
                    amenities = form.amenities.data,
                    listing_description = form.listing_description.data,
                    total_floor = form.total_floor.data,
                    total_room = form.total_room.data,
                    room_area = form.room_area.data,
                    room_name = form.room_name.data,
                    room_price = form.room_price.data,   
                    discount = form.discount.data,                                                                                                                   
                    additional_info=form.additional_info.data)
        
        db.session.add(listing)
        db.session.commit()
        flash('Thanks for Listing!')
        return redirect(url_for('listings.upload'))
    
    return render_template('add-second-listing.html',form=form)

@listings.route('/upload',methods=['POST', 'GET'])
@login_required
def upload():

    form = ListingPictureForm()

    if form.validate_on_submit():

        for f in request.files.getlist('file'):
            f.save(os.path.join(os.path.join(listings.root_path, 'upload'), f.filename))
    
        listing_pictures = ListingPictures(user_id=current_user.id,
                    thumbnail_image = form.thumbnail_image.data,
                    gallery_image = form.gallery_image.data)
        
        db.session.add(listing_pictures)
        db.session.commit()
        flash('Thanks for Listing!')
        return redirect(url_for('listings.listing_confirm'))
    
    return render_template('add-pictures-listing.html',form=form)