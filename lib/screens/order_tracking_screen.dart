import 'package:flutter/material.dart';
import 'package:bestsender/models/order_model.dart';
import 'package:bestsender/services/order_service.dart';
import 'order_detail_screen.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() async {
    final orderService = OrderService();
    final orders = await orderService.getOrders();
    if (mounted) {
      setState(() {
        _orders = orders;
      });
    }
  }

  void _searchOrder() {
    final searchTerm = _searchController.text;
    if (searchTerm.isNotEmpty) {
      final order = _orders.firstWhere(
        (order) => order.orderNumber == searchTerm,
        orElse: () => Order.empty(), // 使用 Order.empty() 方法替代 null
      );
      if (order.orderNumber.isNotEmpty) { // 检查 orderNumber 是否为空
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(order: order),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('未找到订单')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订单跟踪'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: '输入订单号进行搜索',
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchOrder(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return ListTile(
                    title: Text(order.orderNumber),
                    subtitle: Text(order.status),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
