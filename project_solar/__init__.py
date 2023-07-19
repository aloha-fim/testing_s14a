# project_solar/__init__.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
from dotenv import load_dotenv
import os
from os import environ

load_dotenv(".env")


app = Flask(__name__)

#########################
###### DATABASE SETUP ###
#########################
app.config['SQLALCHEMY_DATABASE_URI'] = environ.get("DATABASE_URL")
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = environ.get("SECRET_KEY")

db = SQLAlchemy(app)
Migrate(app,db)

#################
# LOGIN CONFIGS
login_manager = LoginManager()

login_manager.init_app(app)
login_manager.login_view = 'users.login'


# register blueprints and import
from project_solar.core.views import core
from project_solar.error_pages.handlers import error_pages
app.register_blueprint(core)
app.register_blueprint(error_pages)