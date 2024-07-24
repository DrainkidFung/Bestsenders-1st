from flask import Blueprint, jsonify, request

# 创建一个蓝图对象
route_query_bp = Blueprint('route_query_bp', __name__)

# 示例路由1：返回一个简单的 JSON 响应
@route_query_bp.route('/query', methods=['GET'])
def query():
    response = {
        'message': 'This is the query route.',
        'status': 'success'
    }
    return jsonify(response)

# 示例路由2：处理 POST 请求并返回请求数据
@route_query_bp.route('/submit', methods=['POST'])
def submit_query():
    data = request.get_json()
    response = {
        'message': 'Data received successfully.',
        'received_data': data,
        'status': 'success'
    }
    return jsonify(response)
