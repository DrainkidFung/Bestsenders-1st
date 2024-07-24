# routes/finance.py
from flask import Blueprint

finance_bp = Blueprint('finance', __name__)

@finance_bp.route('/finance', methods=['GET'])
def finance():
    return "This is the finance route"
