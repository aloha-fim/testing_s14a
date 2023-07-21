from flask import render_template, url_for, flash, abort, request, redirect, Blueprint
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import SolarPost
from project_solar.solar_posts.forms import SolarPostForm

import joblib
# from sklearn import linear_model
# from sklearn.metrics import r2_score
# from sklearn.model_selection import train_test_split
# from sklearn.ensemble import RandomForestRegressor
import numpy as np
import pandas as pd
import sklearn


solar_posts = Blueprint('solar_posts',__name__)

# modellg = joblib.load("regr.pkl")

file = open('C:/Users/frede/harvard/s14a/regr.pkl', 'rb')
modellg = joblib.load(file)
file.close()

#CREATE
@solar_posts.route('/create', methods=['GET','POST'])
@login_required
def create_post():
    form = SolarPostForm()

    if form.validate_on_submit():

        solar_post = SolarPost(title=form.title.data,
                               text=form.text.data,
                               user_id=current_user.id)
        db.session.add(solar_post)
        db.session.commit()
        flash('Solar Post Created')
        return redirect(url_for('core.index'))
    
    return render_template('create_post.html',form=form)

#VIEW
@solar_posts.route('/<int:solar_post_id>')
def solar_post(solar_post_id):
    solar_post = SolarPost.query.get_or_404(solar_post_id)
    return render_template('solar_post.html', title=solar_post.title,
                           date=solar_post.date,post=solar_post)


#UPDATE
@solar_posts.route('/<int:solar_post_id>/update',methods=['GET','POST'])
@login_required
def update(solar_post_id):
    solar_post = SolarPost.query.get_or_404(solar_post_id)

    if solar_post.author != current_user:
        abort(403)

    form = SolarPostForm()

    if form.validate_on_submit():

        solar_post.title=form.title.data
        solar_post.text=form.text.data
        db.session.commit()
        flash('Solar Post Updated')
        return redirect(url_for('solar_posts.solar_post',solar_post_id=solar_post.id))

    elif request.method == 'GET':
        form.title.data = solar_post.title 
        form.text.data = solar_post.text
    
    return render_template('create_post.html',title='Update',form=form)


#DELETE
@solar_posts.route('/<int:solar_post_id>/delete',methods=['POST'])
@login_required
def delete_post(solar_post_id):

    solar_post = SolarPost.query.get_or_404(solar_post_id)
    if solar_post.author != current_user:
        abort(403)

    db.session.delete(solar_post)
    db.session.commit()
    flash('Solar Post Deleted')
    return redirect(url_for('core.index'))

@solar_posts.route("/inputprediction")
def input_predict():
    return render_template('results.html')


@solar_posts.route('/predict', methods = ['POST', 'GET'])

def make_prediction():
    
    if request.method=='POST':

        entered_li = []

        beds = request.form.get('beds')
        baths = request.form.get('baths')
        sqft = request.form.get('sqft')


        # make prediction
        entered_li = ([beds, baths, sqft])

        prediction = modellg.predict(np.array(entered_li).astype(float).reshape(1, -1))
        
        label = str(np.squeeze(prediction.round(2)))

        return render_template('results.html', label=label)
