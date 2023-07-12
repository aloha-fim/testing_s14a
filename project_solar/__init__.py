# project_solar/__init__.py
from flask import Flask

app = Flask(__name__)


from project_solar.core.views import core
app.register_blueprint(core)
