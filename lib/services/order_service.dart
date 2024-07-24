import 'package:bestsender/models/order_model.dart';

class OrderService {
  Future<void> submitOrder(Order order) async {
    // 模拟提交订单操作
    await Future.delayed(const Duration(seconds: 2));
    // 这里可以添加实际的提交订单逻辑，比如调用API
  }

  Future<List<Order>> getOrders() async {
    // 模拟获取订单列表
    await Future.delayed(const Duration(seconds: 2));
    return [
      Order(
        orderNumber: 'ORD123456',
        originPort: '上海',
        destinationPort: '洛杉矶',
        cargoName: '电子产品',
        containerType: '40尺高柜',
        containerQuantity: 2,
        weightPerContainer: 1000.0,
        shippingDate: DateTime.now(),
        loadingDate: DateTime.now().add(const Duration(days: 1)),
        vesselName: 'Evergreen',
        voyageNumber: 'EGL123',
        containerNumbers: ['CONT1', 'CONT2'],
        status: '运输中',
        originServiceMode: 'CY',
        destinationServiceMode: 'SD',
        needTemperatureControl: false,
        isDangerousGoods: false,
        useOwnContainer: false,
      ),
      // 可以添加更多订单
    ];
  }
}
