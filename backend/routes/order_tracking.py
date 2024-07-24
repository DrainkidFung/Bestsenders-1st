# routes/order_tracking.py
from flask import Blueprint

order_tracking_bp = Blueprint('order_tracking', __name__)

@order_tracking_bp.route('/order_tracking', methods=['GET'])
def order_tracking():
    return "This is the order tracking route"
