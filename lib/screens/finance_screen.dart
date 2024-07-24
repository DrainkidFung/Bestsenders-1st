import 'package:flutter/material.dart';
import 'package:bestsender/models/transaction_model.dart';
import 'package:bestsender/services/finance_service.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() async {
    final financeService = FinanceService();
    final transactions = await financeService.getTransactions();
    if (mounted) {
      setState(() {
        _transactions = transactions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('财务管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (context, index) {
            final transaction = _transactions[index];
            return ListTile(
              title: Text(transaction.description),
              subtitle: Text('金额: \$${transaction.amount.toStringAsFixed(2)}'),
              trailing: Text('${transaction.date.year}-${transaction.date.month}-${transaction.date.day}'),
            );
          },
        ),
      ),
    );
  }
}
