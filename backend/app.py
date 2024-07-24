from flask import Flask
from routes.logistics_query import logistics_query_bp
from routes.route_query import route_query_bp
from routes.quote_query import quote_query_bp
from routes.order import order_bp
from routes.order_tracking import order_tracking_bp
from routes.finance import finance_bp
from routes.points import points_bp
from urllib.parse import quote as url_quote  # 使用 urllib.parse.quote 代替

# 创建 Flask 应用实例
app = Flask(__name__)

# 注册蓝图，并设置 URL 前缀
app.register_blueprint(logistics_query_bp, url_prefix='/logistics_query')
app.register_blueprint(route_query_bp, url_prefix='/route_query')
app.register_blueprint(quote_query_bp, url_prefix='/quote_query')
app.register_blueprint(order_bp, url_prefix='/order')
app.register_blueprint(order_tracking_bp, url_prefix='/order_tracking')
app.register_blueprint(finance_bp, url_prefix='/finance')
app.register_blueprint(points_bp, url_prefix='/points')

# 定义根路由
@app.route('/')
def home():
    return 'Backend is running!'

# 主程序入口
if __name__ == '__main__':
    app.run(debug=True)
