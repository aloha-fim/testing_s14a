"""pictures upload

Revision ID: 0ed6d4c82b66
Revises: d45dfd5fd529
Create Date: 2023-10-28 10:49:29.010341

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '0ed6d4c82b66'
down_revision = 'd45dfd5fd529'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('stripe_customer',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=False),
    sa.Column('date', sa.DateTime(), nullable=False),
    sa.Column('listing_id', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    with op.batch_alter_table('listing_pictures', schema=None) as batch_op:
        batch_op.add_column(sa.Column('gallery_images', sa.String(length=1024), nullable=True))
        batch_op.alter_column('thumbnail_image',
               existing_type=sa.VARCHAR(length=140),
               type_=sa.String(length=1024),
               existing_nullable=True)
        batch_op.drop_column('gallery_image')

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('listing_pictures', schema=None) as batch_op:
        batch_op.add_column(sa.Column('gallery_image', sa.VARCHAR(length=140), autoincrement=False, nullable=True))
        batch_op.alter_column('thumbnail_image',
               existing_type=sa.String(length=1024),
               type_=sa.VARCHAR(length=140),
               existing_nullable=True)
        batch_op.drop_column('gallery_images')

    op.drop_table('stripe_customer')
    # ### end Alembic commands ###
