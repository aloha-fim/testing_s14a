"""jinja implementation

Revision ID: 4f5d3c230e39
Revises: 346d29f83878
Create Date: 2023-09-13 10:30:29.709357

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '4f5d3c230e39'
down_revision = '346d29f83878'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('listing_second_post',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=False),
    sa.Column('date', sa.DateTime(), nullable=False),
    sa.Column('amenities', sa.String(length=140), nullable=False),
    sa.Column('listing_description', sa.String(length=140), nullable=False),
    sa.Column('total_floor', sa.String(length=140), nullable=False),
    sa.Column('total_room', sa.String(length=140), nullable=False),
    sa.Column('room_area', sa.String(length=140), nullable=False),
    sa.Column('room_name', sa.String(length=140), nullable=False),
    sa.Column('room_price', sa.String(length=140), nullable=False),
    sa.Column('discount', sa.String(length=140), nullable=False),
    sa.Column('additional_info', sa.String(length=140), nullable=False),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    with op.batch_alter_table('listing_post', schema=None) as batch_op:
        batch_op.drop_column('listing_description')
        batch_op.drop_column('room_name')
        batch_op.drop_column('total_floor')
        batch_op.drop_column('discount')
        batch_op.drop_column('total_room')
        batch_op.drop_column('additional_info')
        batch_op.drop_column('amenities')
        batch_op.drop_column('room_price')
        batch_op.drop_column('room_area')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('listing_post', schema=None) as batch_op:
        batch_op.add_column(sa.Column('room_area', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('room_price', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('amenities', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('additional_info', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('total_room', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('discount', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('total_floor', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('room_name', sa.VARCHAR(length=140), autoincrement=False, nullable=False))
        batch_op.add_column(sa.Column('listing_description', sa.VARCHAR(length=140), autoincrement=False, nullable=False))

    op.drop_table('listing_second_post')
    # ### end Alembic commands ###
