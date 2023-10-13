from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app
from flask_login import current_user, login_required
from werkzeug.utils import secure_filename
from project_solar import db
from project_solar.models import ListingPost, ListingSecondPost, ListingPictures
from project_solar.listings.forms import ListingPostForm, ListingSecondPostForm, ListingPictureForm
from project_solar.listings.picture_handler import add_listing_pic
import os


listings = Blueprint('listings',__name__, template_folder="templates")

@listings.route("/tour_detail/<int:listing_id>", methods=["GET","POST"])
def details(listing_id):
     
    # if no listing_id provided, redirect to prior page
	#if listing_id == None:
	#	return redirect(url_for("listings.results"))
      
    # get user or 404
    #listingdetails = ListingPost.query.join(ListingSecondPost, ListingPost.id==ListingSecondPost.id).join(ListingPictures, ListingPost.id==ListingPictures.id).filter_by(id=listing_id).first_or_404()    
    #listingdetails = db.session.query(ListingPost,ListingSecondPost,ListingPictures).filter(ListingPost.id==ListingSecondPost.id,ListingPost.id==ListingPictures.id).first_or_404()
    listingPosts = ListingPost.query.filter_by(id=listing_id)
    listingSecondPosts = ListingSecondPost.query.filter_by(id=listing_id)
    listingPicturePosts = ListingPictures.query.filter_by(id=listing_id)
    
    return render_template('listings/tour-detail.html', listingPosts=listingPosts, listingSecondPosts=listingSecondPosts, listingPicturePosts=listingPicturePosts)

@listings.route('/results_list')
def results():
    page = request.args.get('page',1,type=int)
    posts = db.session.query(ListingPost,ListingSecondPost,ListingPictures).filter(ListingPost.id==ListingSecondPost.id,ListingPost.id==ListingPictures.id).order_by(ListingPost.date.desc()).paginate(page=page,per_page=50)   
   # posts = db.session.query(ListingPost,ListingSecondPost,ListingPictures).join(ListingSecondPost,ListingPost.id==ListingSecondPost.id).join(ListingPictures,ListingPost.id==ListingPictures.id).order_by(ListingPost.date.desc()).paginate(page=page,per_page=10)   
   # posts = ListingPost.query.order_by(ListingPost.date.desc()).paginate(page=page,per_page=5)
    return render_template('listings/tour-grid.html', posts=posts)


@listings.route('/listing_confirm')
def listing_confirm():
    return render_template('listings/listing-added.html')

@listings.route('/create_creation')
def create_listing():
    return render_template('listings/join-us.html')

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
    
    return render_template('listings/add-listing.html',form=form)


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
    
    return render_template('listings/add-second-listing.html',form=form)

@listings.route('/upload', methods=['POST', 'GET'])
@login_required
def upload():

    form = ListingPictureForm()

    if request.method == 'POST':

       
        #for f in request.files.getlist('file'):
        for file in request.files.getlist('file'):
            #filename = secure_filename(f.filename)
            #f.save(os.path.join(os.path.join(listings.root_path, 'static'), f.filename))
            file.save(os.path.join(os.path.join(listings.root_path, 'static'), file.filename))
            #file.save(os.path.join(current_app.config['GALLERY_FOLDER'], file.filename))
            #f.save(os.path.join(listings.root_path, 'static\listing_pics', f.filename))
            #f.save(os.path.join(current_app.root_path, 'static\listing_pics',f.filename))
            #f.save(os.path.join(os.path.join(listings.root_path, 'upload'), f.filename))
            #f.save(os.path.join(current_app.root_path + '/'+ 'static/listing_pics/'),f.filename)
            #f.save(os.path.join(os.path.join(listings.root_path, 'static'), f.filename))

        #files_filenames = []
        #for file in request.files.getlist('files'):
            ##file_filename = secure_filename(file.filename)
            #file.save(os.path.join(current_app.config['UPLOAD_FOLDER'], file.filename))
            #files_filenames.append(file.filename)

    if form.validate_on_submit():
        #filename = secure_filename(form.thumbnail_image.data.filename)
        listing_pictures = ListingPictures(user_id=current_user.id,
                    thumbnail_image = form.thumbnail_image.data)
                    #gallery_image = form.gallery_image.data)

        db.session.add(listing_pictures)
        db.session.commit()

        flash('Thanks for Listing!')
        return redirect(url_for('listings.listing_confirm'))
    
    return render_template('listings/add-pictures-listing.html',form=form)