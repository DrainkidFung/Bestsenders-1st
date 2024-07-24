import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // 导入 TimeoutException

class LogisticsQueryScreen extends StatefulWidget {
  const LogisticsQueryScreen({super.key});

  @override
  _LogisticsQueryScreenState createState() => _LogisticsQueryScreenState();
}

class _LogisticsQueryScreenState extends State<LogisticsQueryScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  final List<String> _history = [];

  Future<void> _fetchLogisticsInfo(String trackingNumber) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.100:5000/logistics_query?trackingNumber=$trackingNumber'), // 替换为实际的后端URL
        headers: {
          'Primary-Key': 'ef0a82e105bb482ba7cf01c268466b54',
          'Secondary-Key': '6dbc8715fc9546b7800be1ec19c463e0',
        },
      ).timeout(const Duration(seconds: 10)); // 设置超时时间为10秒，并添加 const 关键字

      if (!mounted) return; // 检查组件是否仍然挂载
      if (response.statusCode == 200) {
        setState(() {
          _result = json.decode(response.body)['data'];
          _history.add(trackingNumber);
        });
      } else {
        setState(() {
          _result = 'Failed to fetch data: ${response.statusCode}';
        });
      }
    } on TimeoutException catch (_) { // 捕获 TimeoutException
      if (!mounted) return; // 检查组件是否仍然挂载
      setState(() {
        _result = 'Failed to fetch data: 请求超时';
      });
    } catch (error) {
      if (!mounted) return; // 检查组件是否仍然挂载
      setState(() {
        _result = 'Failed to fetch data: $error';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('物流查询'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter tracking number',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _fetchLogisticsInfo(_controller.text);
              },
              child: const Text('Query'), // 添加 const 关键字
            ),
            const SizedBox(height: 16),
            Text(_result),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                    onTap: () {
                      _controller.text = _history[index];
                      _fetchLogisticsInfo(_history[index]);
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
