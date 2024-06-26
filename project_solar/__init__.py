# project_solar/__init__.py
from flask import Flask
from project_solar.json_serializable import JSONSerializable
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
from dotenv import load_dotenv
import os
from os import environ

load_dotenv(".env")


app = Flask(__name__)
JSONSerializable(app)

#########################
###### DATABASE SETUP ###
#########################
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get("DATABASE_URL")
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = environ.get("SECRET_KEY")






db = SQLAlchemy(app)
Migrate(app,db)

app.app_context().push()

############################################################
# START localhost virtual environment ######################
# virtualenv venv for python 2.7 and Windows
# python3 -m venv venv for python 3+
# source venv/bin/activate
# .\venv\Scripts\activate for Windows
# pip install -r requirements.txt for setup
# pip freeze > requirements.txt for update after pip install
# python3 app.py
############################################################

############################################################
# Flask DB commands after pip3 install migrate workflow ####
# 1) flask db init / flask db stamp head
# 2) flask db migrate -m "first migration"
# 3) flask db upgrade
# to push migrations
# 4) python3 app.py
############################################################

############################################################
#stripe..x8>stripe login
#stripe listen --forward-to localhost:4242/webhook
#stripe trigger payment_intent.succeeded
#stripe listen --forward-connect-to localhost:5000/listings/webhook
#stripe trigger payment_intent.succeeded
############################################################



#################
# LOGIN CONFIGS
login_manager = LoginManager()

login_manager.init_app(app)
login_manager.login_view = 'users.login'


# register blueprints and
from project_solar.accounts.views import accounts
from project_solar.core.views import core
from project_solar.users.views import users
from project_solar.listings.views import listings
from project_solar.solar_posts.views import solar_posts
from project_solar.error_pages.handlers import error_pages
app.register_blueprint(accounts, url_prefix="/accounts")
app.register_blueprint(core)
app.register_blueprint(users)
app.register_blueprint(listings, url_prefix="/listings")
app.register_blueprint(solar_posts)
app.register_blueprint(error_pages)