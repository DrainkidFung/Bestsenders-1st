# routes/points.py
from flask import Blueprint

points_bp = Blueprint('points', __name__)

@points_bp.route('/points', methods=['GET'])
def points():
    return "This is the points route"
