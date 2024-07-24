import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/logistics_query');
              },
              child: const Text('物流查询'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/route_query');
              },
              child: const Text('航线查询'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quote_query');
              },
              child: const Text('报价查询'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/order');
              },
              child: const Text('自助下单'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/order_tracking');
              },
              child: const Text('订单跟踪'),
            ),
          ],
        ),
      ),
    );
  }
}
