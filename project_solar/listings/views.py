from flask import render_template, url_for, flash, abort, request, redirect, Blueprint
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import ListingPost
from project_solar.listings.forms import ListingPostForm


listings = Blueprint('listings',__name__)