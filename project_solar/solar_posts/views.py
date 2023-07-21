from flask import render_template, url_for, flash, request, redirect, Blueprint
from flask_login import current_user, login_required
from project_solar import db
from project_solar.models import SolarPost
from project_solar.solar_posts.forms import SolarPostForm

solar_posts = Blueprint('solar_posts',__name__)

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

#UPDATE

#DELETE