# routes/order.py
from flask import Blueprint

order_bp = Blueprint('order', __name__)

@order_bp.route('/order', methods=['GET'])
def order():
    return "This is the order route"
