# project_solar/__init__.py
from flask import Flask

app = Flask(__name__)

# register blueprints and import
from project_solar.core.views import core
from project_solar.error_pages.handlers import error_pages
app.register_blueprint(core)
app.register_blueprint(error_pages)
