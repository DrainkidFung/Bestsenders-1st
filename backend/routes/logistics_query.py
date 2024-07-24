from flask import Blueprint, request, jsonify
import requests

logistics_query_bp = Blueprint('logistics_query', __name__)

@logistics_query_bp.route('/', methods=['GET'])
def get_logistics_info():
    tracking_number = request.args.get('trackingNumber')
    if not tracking_number:
        return jsonify({"status": "error", "message": "Tracking number is required"}), 400

    primary_key = request.headers.get('Primary-Key')
    secondary_key = request.headers.get('Secondary-Key')

    if not primary_key or not secondary_key:
        return jsonify({"status": "error", "message": "API keys are required"}), 400

    try:
        # 调用ZIM船公司的Track API
        response = requests.get(
            f'https://www.zim.com/tools/track-a-shipment?consnumber={tracking_number}',
            headers={
                'Primary-Key': primary_key,
                'Secondary-Key': secondary_key,
            }
        )
        if response.status_code == 200:
            data = response.json()
            return jsonify({"status": "success", "data": data}), 200
        else:
            return jsonify({"status": "error", "message": f"Failed to fetch data: {response.status_code}"}), response.status_code
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
