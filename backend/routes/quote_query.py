# routes/quote_query.py

from flask import Blueprint, jsonify

# 创建一个 Blueprint 对象
quote_query_bp = Blueprint('quote_query', __name__)

# 定义一个简单的路由
@quote_query_bp.route('/quotes', methods=['GET'])
def get_quotes():
    # 示例数据
    quotes = [
        {"id": 1, "text": "The best way to predict the future is to invent it."},
        {"id": 2, "text": "Life is 10% what happens to us and 90% how we react to it."}
    ]
    return jsonify(quotes)
