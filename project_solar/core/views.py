from flask import render_template,request,Blueprint
from project_solar.models import SolarPost

core = Blueprint('core',__name__)

@core.route('/')
def index():
    '''
    This is the home page view calling paginate.
    '''
    page = request.args.get('page', 1, type=int)
    solar_posts = SolarPost.query.order_by(SolarPost.date.desc()).paginate(page=page, per_page=10)
    return render_template('index.html',solar_posts=solar_posts)


@core.route('/info')
def info():
    return render_template('info.html')

@core.route('/start')
def start():
    return render_template('index-directory.html')