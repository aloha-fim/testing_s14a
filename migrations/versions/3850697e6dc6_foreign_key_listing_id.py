"""foreign key listing_id

Revision ID: 3850697e6dc6
Revises: 61f55431d5d2
Create Date: 2023-10-08 16:46:54.313224

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '3850697e6dc6'
down_revision = '61f55431d5d2'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('listing_pictures', schema=None) as batch_op:
        batch_op.alter_column('listing_id',
               existing_type=sa.INTEGER(),
               nullable=False,
               autoincrement=True)

    with op.batch_alter_table('listing_second_post', schema=None) as batch_op:
        batch_op.alter_column('listing_id',
               existing_type=sa.INTEGER(),
               nullable=False,
               autoincrement=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('listing_second_post', schema=None) as batch_op:
        batch_op.alter_column('listing_id',
               existing_type=sa.INTEGER(),
               nullable=True,
               autoincrement=True)

    with op.batch_alter_table('listing_pictures', schema=None) as batch_op:
        batch_op.alter_column('listing_id',
               existing_type=sa.INTEGER(),
               nullable=True,
               autoincrement=True)

    # ### end Alembic commands ###
