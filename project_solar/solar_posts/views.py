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

import os
import pickle
import zipfile
import torch

from PIL import Image
#VSCode Command(or Ctrl)+Shift+P then searching "select python interpreter" and actually select the python environment where you installed the transformers library.
from transformers import ViTForImageClassification, ViTImageProcessor

from utils import latlong, load_model, extract_pickle_file, extract_zip_file, decompress_pickle

from cnn_image_features import get_cnn_features
from cnn_cam import get_cam

from torchvision.utils import save_image

import matplotlib.pyplot as plt


solar_posts = Blueprint('solar_posts',__name__)

file = open('best_model_scaled.pkl', 'rb')
model_best = joblib.load(file)
file.close()

boston_real_estate_file = open('best_model_scaled.pkl', 'rb')   # 'rb' for reading binary file
model_scaled = joblib.load(boston_real_estate_file)     
boston_real_estate_file.close() 

# Define the path to the model files
BEST_MODEL_FILE_NAME_SCALED = "best_model_scaled.pkl"
BEST_MODEL_ZIP_NAME_SCALED = "best_model_scaled.zip"
BEST_MODEL_PBZ2 = "best_model.pkl"
BEST_MODEL_PBZ2_CNN = "best_model_cnn.pkl"

current_dir = os.path.dirname(os.path.realpath(__file__))

BEST_MODEL_PICKLE_PATH_SCALED = os.path.join(current_dir, BEST_MODEL_FILE_NAME_SCALED)
BEST_MODEL_ZIP_PATH_SCALED = os.path.join(current_dir, BEST_MODEL_ZIP_NAME_SCALED)
BEST_MODEL_PBZ2_PATH = os.path.join(current_dir, BEST_MODEL_PBZ2)
BEST_MODEL_PBZ2_CNN_PATH = os.path.join(current_dir, BEST_MODEL_PBZ2_CNN)

with open(BEST_MODEL_PBZ2_CNN_PATH, "rb") as cnn_file:
    model_cnn = joblib.load(cnn_file)
    cnn_file.close()

with open(BEST_MODEL_PBZ2_PATH, "rb") as boston_real_estate_file:
    model = joblib.load(boston_real_estate_file)
    boston_real_estate_file.close()


# Load the pre-trained Vision Transformer model
vit_model = ViTForImageClassification.from_pretrained("google/vit-base-patch16-224")
processor = ViTImageProcessor.from_pretrained("google/vit-base-patch16-224")




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

#original linear regression route for result
@solar_posts.route("/inputprediction")
def input_predict():
    return render_template('results.html')

#original linear regression route for input
@solar_posts.route('/predict', methods = ['POST', 'GET'])

def make_prediction():
    
    if request.method=='POST':

        entered_li = []

        beds = request.form.get('beds')
        baths = request.form.get('baths')
        sqft = request.form.get('sqft')


        # make prediction
        entered_li = ([beds, baths, sqft])

        prediction = model_best.predict(np.array(entered_li).astype(float).reshape(1, -1))
        
        label = str(np.squeeze(prediction.round(2)))

        return render_template('results.html', label=label)


# refactored linear regression route for result
@solar_posts.route("/predict_scaled")
# Load model, get user-inputted data features from form, and then predict sales price to be displayed
# Will need to process input address to return latitude and longitude using API
def predict_scaled():
    return render_template("predict_scaled.html")

# refactored linear regression route for input
@solar_posts.route("/predicted_scaled", methods=["GET", "POST"])
# Load model, get user-inputted data features from form, and then predict sales price to be displayed
def predicted_scaled():
    if request.method == "POST":

        # # Load the trained model, but cannot use pickle because save was in joblib
        # with open("best_model_scaled.pkl", "rb") as boston_real_estate_file:
        #     model = pickle.load(boston_real_estate_file)

        # Get form data
        beds = float(request.form.get("beds"))
        baths = float(request.form.get("baths"))
        sqft = float(request.form.get('sqft'))


        # Prepare the feature vector for prediction
        feature_vector = [[beds, baths, sqft]]

        # Make prediction
        prediction = model_scaled.predict(feature_vector)

        # Convert prediction to a string so it can be displayed
        prediction_string = str(prediction[0])

        # build a dictionary with the data

        property_dict = {
            "beds": beds,
            "baths": baths,
            "sqft": sqft,
            "prediction": prediction_string,
        }

        return render_template("predicted_scaled.html", property_dict=property_dict)

    return render_template("index.html")

# Transformer CNN route for result
@solar_posts.route("/predict_scaled_best_input")
# Load model, get user-inputted data features from form, and then predict sales price to be displayed
# Will need to process input address to return latitude and longitude using API
def predict_scaled_best_input():
    return render_template("predicted_scaled_best_input.html")

# Transformer CNN route for input
@solar_posts.route("/predicted_scaled_best", methods=["GET", "POST"])
# Load model, get user-inputted data features from form, and then predict sales price to be displayed
# Will need to process input address to return latitude and longitude using API
def predicted_scaled_best():
    if request.method == "POST":
        
        # Get the image file from the POST request
        image_file = request.files.get("propertyimage")
        
        # Define the directory for uploads and create it if it doesn't exist
        # upload_dir = os.path.join(os.path.dirname(__file__), "static", "uploads")
        # if not os.path.exists(upload_dir):
        #     os.makedirs(upload_dir)

        upload_dir = os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'static/uploads'))
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)

        # Define the path to save the image
        image_path = os.path.join(upload_dir, image_file.filename)

        image = None
        img_features = None

        if image_file != None:
            # Convert the image file to a PIL Image and save it
            image = Image.open(image_file.stream)
            img_features = get_cnn_features(image)
            image.save(image_path)

        # get CAM image
        cam_image = get_cam(image)
        plt.imshow(cam_image)
        plt.axis('off')
        plt.tight_layout()
        plt.savefig(upload_dir +'/cnn_'+ image_file.filename)
        # Define the path to save the image
        image_url = url_for("static", filename="uploads/" + image_file.filename)
        cam_image_url = url_for("static", filename="uploads/" + 'cnn_'+ image_file.filename)

        # Get form data
        address = request.form.get("address")
        beds = float(request.form.get("beds"))
        baths = float(request.form.get("baths"))
        age = float(request.form.get("age"))
        lotsize = float(request.form.get("lotsize"))
        garages = float(request.form.get("garages"))
        sqrft = float(request.form.get('sqrft'))
        
        # get latitude and longitude
        lat, lon = latlong(address)

        # Prepare the feature vector for prediction
        feature_vector = [[age, lotsize, garages, lat, lon, beds, baths, sqrft]]
        
        # Make prediction        
        prediction = model.predict(feature_vector)

        [feature_vector[0].append(x) for x in img_features]


        prediction_cnn = model_cnn.predict(feature_vector)

        # Convert prediction to a string so it can be displayed
        prediction_string = str(prediction[0])
        
        prediction_cnn_string = str(prediction_cnn[0])

        # build a dictionary with the data

        property_dict = {
            "address": address,
            "beds": beds,
            "baths": baths,
            "lotsize": lotsize,
            "garages": garages,
            "squarefeet":sqrft, 
            "prediction": prediction_string,
            "prediction_cnn": prediction_cnn_string,
            "image_url": image_url,
            "cam_img_url": cam_image_url
        }
                
        return render_template("predicted_scaled_best.html", property_dict=property_dict)

    return render_template("predicted_scaled_best_input.html")




# Add a listing
@solar_posts.route("/add_listing")
# Listing add
def add_listing():
    return render_template("add-listing.html")
