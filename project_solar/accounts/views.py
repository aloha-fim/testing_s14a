from flask import render_template, url_for, flash, abort, request, redirect, Blueprint, current_app
from flask_login import current_user, login_required, login_user, logout_user
from project_solar import db
from project_solar.models import ListingPost, ListingSecondPost, ListingPictures, User, StripeCustomer
from project_solar.listings.forms import ListingPostForm, ListingSecondPostForm, ListingPictureForm
from project_solar.users.forms import RegistrationForm, LoginForm, UpdateUserForm 
from project_solar.users.picture_handler import add_profile_pic
import os

accounts = Blueprint('accounts',__name__, template_folder="templates")

@accounts.route('/agent_dashboard')
def agent_dashboard():
    return render_template('accounts/agent-dashboard.html')



@accounts.route('/account_bookings',methods=['GET','POST'])
@login_required
def account_bookings():
    stripeCustomer = StripeCustomer.query.filter_by(user_id=current_user.id)
    paidPosts = ListingPost.query.filter(ListingPost.user_id == current_user.id, ListingPost.id == StripeCustomer.listing_id).all()

    # page = request.args.get('page',1,type=int)
    # posts = db.session.query(ListingPost,ListingSecondPost,ListingPictures).filter(ListingPost.id==ListingSecondPost.id,ListingPost.id==ListingPictures.id).order_by(ListingPost.date.desc()).paginate(page=page,per_page=9)  
    form = UpdateUserForm()
    if form.validate_on_submit():
    
        if form.picture.data:
            username = current_user.username
            pic = add_profile_pic(form.picture.data,username)
            current_user.profile_image = pic

        current_user.username = form.username.data
        current_user.email = form.email.data
        db.session.commit()
        flash('User Account Updated!')
        return redirect(url_for('users.account'))
    
    elif request.method == "GET":
        form.username.data = current_user.username
        form.email.data = current_user.email

    profile_image = url_for('static', filename='profile_pics/'+current_user.profile_image) 
    return render_template('accounts/account-bookings.html',profile_image=profile_image,form=form,paidPosts=paidPosts)