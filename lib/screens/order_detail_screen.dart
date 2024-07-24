import 'package:flutter/material.dart';
import 'package:bestsender/models/order_model.dart'; // 确保路径正确

class OrderDetailScreen extends StatelessWidget {
  final Order order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情 - ${order.orderNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('发件地址: ${order.originPort}'),
            Text('收件地址: ${order.destinationPort}'),
            Text('货物名称: ${order.cargoName}'),
            Text('集装箱类型: ${order.containerType}'),
            Text('集装箱数量: ${order.containerQuantity}'),
            Text('每个集装箱的重量: ${order.weightPerContainer} kg'),
            Text('起运日期: ${order.shippingDate}'),
            Text('装柜日期: ${order.loadingDate}'),
            Text('船名: ${order.vesselName}'),
            Text('航次号: ${order.voyageNumber}'),
            Text('集装箱编号: ${order.containerNumbers.join(', ')}'),
            Text('状态: ${order.status}'),
            Text('始发地服务模式: ${order.originServiceMode}'),
            Text('目的地服务模式: ${order.destinationServiceMode}'),
            Text('需要温控: ${order.needTemperatureControl ? "是" : "否"}'),
            Text('危险货物: ${order.isDangerousGoods ? "是" : "否"}'),
            Text('自有集装箱: ${order.useOwnContainer ? "是" : "否"}'),
          ],
        ),
      ),
    );
  }
}
