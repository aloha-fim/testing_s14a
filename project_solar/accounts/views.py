from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import ListingPost, ListingSecondPost, ListingPictures
from project_solar.listings.forms import ListingPostForm, ListingSecondPostForm, ListingPictureForm
import os

accounts = Blueprint('accounts',__name__, template_folder="templates")

@accounts.route('/account_bookings')
def account_bookings():
    # page = request.args.get('page',1,type=int)
    # posts = db.session.query(ListingPost,ListingSecondPost,ListingPictures).filter(ListingPost.id==ListingSecondPost.id,ListingPost.id==ListingPictures.id).order_by(ListingPost.date.desc()).paginate(page=page,per_page=9)   

    return render_template('accounts/account-bookings.html')