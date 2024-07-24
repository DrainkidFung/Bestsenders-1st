import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteQueryScreen extends StatefulWidget {
  const QuoteQueryScreen({Key? key}) : super(key: key);

  @override
  _QuoteQueryScreenState createState() => _QuoteQueryScreenState();
}

class _QuoteQueryScreenState extends State<QuoteQueryScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  String _result = '';
  List<Map<String, String>> _history = [];

  Future<void> _fetchQuote(String source, String destination) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.example.com/getQuote?source=$source&destination=$destination'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _result = 'Quote: \$${data['quote']}';
          _history.add({'source': source, 'destination': destination}); // 添加到历史记录
        });
      } else {
        setState(() {
          _result = 'Failed to fetch data: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _result = 'Failed to fetch data: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('报价查询'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: '请输入起始地',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: '请输入目的地',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _fetchQuote(_sourceController.text, _destinationController.text);
              },
              child: const Text('查询报价'),
            ),
            const SizedBox(height: 16),
            Text(_result),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '起始地: ${_history[index]['source']} 目的地: ${_history[index]['destination']}'),
                    onTap: () {
                      _sourceController.text = _history[index]['source']!;
                      _destinationController.text = _history[index]['destination']!;
                      _fetchQuote(_history[index]['source']!, _history[index]['destination']!);
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
