from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app, jsonify
from flask_login import current_user, login_required
from werkzeug.utils import secure_filename
from project_solar import db
from project_solar.models import ListingPost, ListingSecondPost, ListingPictures
from project_solar.listings.forms import ListingPostForm, ListingSecondPostForm, ListingPictureForm
from project_solar.listings.picture_handler import add_listing_pic
from project_solar.listings.picture_format import allowed_file
import os
import stripe

UPLOAD_FOLDER = 'static\listing_pics'



listings = Blueprint('listings',__name__, template_folder="templates")
current_app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

stripe_keys = {
    "secret_key": os.environ["STRIPE_SECRET_KEY"],
    "publishable_key": os.environ["STRIPE_PUBLISHABLE_KEY"],
    "endpoint_secret": os.environ["STRIPE_WEBHOOK_SECRET"],
}

stripe.api_key = stripe_keys["secret_key"]


@listings.route("/config")
def get_publishable_key():
    stripe_config = {"publicKey": stripe_keys["publishable_key"]}
    return jsonify(stripe_config)


@listings.route("/create-checkout-session")
def create_checkout_session():
    domain_url = "http://127.0.0.1:5000/"
    stripe.api_key = stripe_keys["secret_key"]

    try:
        # Create new Checkout Session for the order
        # Other optional params include:
        # [billing_address_collection] - to display billing address details on the page
        # [customer] - if you have an existing Stripe Customer ID
        # [payment_intent_data] - capture the payment later
        # [customer_email] - prefill the email input in the form
        # For full details see https://stripe.com/docs/api/checkout/sessions/create

        # ?session_id={CHECKOUT_SESSION_ID} means the redirect will have the session ID set as a query param
        checkout_session = stripe.checkout.Session.create(
            success_url=domain_url + "listings/success?session_id={CHECKOUT_SESSION_ID}",
            cancel_url=domain_url + "listings/cancelled",
            payment_method_types=["card"],
            mode="payment",
            line_items=[
                {
                    "quantity": 1,
                    "price_data": {
                        "currency": "usd",
                        "unit_amount": 2000,
                        "product_data": {
                            "name": "T-shirt"
                        },
                    },
                }
            ],
            metadata = {
                "user_id": current_user.id
            } 
            
        )
        return jsonify({"sessionId": checkout_session["id"]})
    except Exception as e:
        return jsonify(error=str(e)), 403


@listings.route("/webhook", methods=['POST'])
def stripe_webhook():
    payload = request.get_data(as_text=True)
    sig_header = request.headers.get('Stripe-Signature')

    try:
        event = stripe.Webhook.construct_event(
            payload, sig_header, stripe_keys["endpoint_secret"]
        )

    except ValueError as e:
        # Invalid payload
        return 'Invalid payload', 400
    except stripe.error.SignatureVerificationError as e:
        # Invalid signature
        return 'Invalid signature', 400

    # Handle the checkout.session.completed event
    if event['type'] == 'checkout.session.completed':
        session = event['data']['object']
        print(f'Sale to {session.customer_details.email}:')
        print("Sale to stripe works")
        # Fulfill the purchase...
        handle_checkout_session(session)

    #if event['type'] == 'checkout.session.completed':
    #  session = stripe.checkout.Session.retrieve(
    #      event['data']['object'].id, expand=['line_items'])
    #  print(f'Sale to {session.customer_details.email}:')
    #  handle_checkout_session(session)
    return 'Success', 200


def handle_checkout_session(session):
    print("Payment was successful.")
    # TODO: run some custom code here

    for item in session.line_items.data:
        print(f'Item quantity: {item.quantity} - {item.currency.upper()}')
            #  f'${item.amount_total/100:.02f} {item.currency.upper()}')


@listings.route("/success")
def success():
    sessions = stripe.checkout.Session.list()
    print(sessions.data[00]) # tree view
    data = {'username': sessions.data[00].metadata.user_id}
    return render_template("listings/success.html", data=data)


@listings.route("/cancelled")
def cancelled():
    return render_template("listings/cancelled.html")


@listings.route('/booking_confirm')
def booking_confirm():
    return render_template('listings/booking-confirm.html')


@listings.route("/booking_start/<int:listing_id>", methods=["GET","POST"])
@login_required
def booking_start(listing_id):
    listingPosts = ListingSecondPost.query.get(listing_id)

    price = listingPosts.room_price
    service_fee = float(listingPosts.room_price) * 0.15
    
    total_price = float(price) + float(service_fee)
    
    if request.method == 'POST':
        #token = request.form['stripeToken']
        #charge = stripe.Charge.create(
        # amount = int(total_price * 100), # 100 = $1.00
        # currency = 'usd',
        # description = 'example charge',
        # source = token)
        
        return render_template('listings/booking-confirm.html', listingPosts=listingPosts, price=price, service_fee=service_fee, total_price=total_price) 

    return render_template('listings/tour-booking.html', listingPosts=listingPosts, service_fee=service_fee, total_price=total_price)


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
    posts = db.session.query(ListingPost,ListingSecondPost,ListingPictures).filter(ListingPost.id==ListingSecondPost.id,ListingPost.id==ListingPictures.id).order_by(ListingPost.date.desc()).paginate(page=page,per_page=9)   
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
        # check if the post request has the file part
        if 'thumbnail_image' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['thumbnail_image']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(current_app.root_path, current_app.config['UPLOAD_FOLDER'], filename))
            #return redirect(url_for('uploaded_file',filename=filename))


    #if request.method == 'POST':

       
        #for f in request.files.getlist('file'):
        #for file in request.files.getlist('file'):
            #filename = secure_filename(f.filename)
            #f.save(os.path.join(os.path.join(listings.root_path, 'static'), f.filename))
            #file.save(os.path.join(os.path.join(listings.root_path, 'static'), file.filename))
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
                    thumbnail_image = filename)
                    #thumbnail_image = form.thumbnail_image.data)
                    #gallery_image = form.gallery_image.data)

        db.session.add(listing_pictures)
        db.session.commit()

        flash('Thanks for Listing!')
        return redirect(url_for('listings.listing_confirm'))
    
    return render_template('listings/add-pictures-listing.html',form=form)