import 'package:bestsender/models/transaction_model.dart';

class FinanceService {
  Future<List<Transaction>> getTransactions() async {
    // 模拟获取交易记录
    await Future.delayed(const Duration(seconds: 2));
    return [
      Transaction(
        transactionId: 'TXN123456',
        description: '订单支付',
        amount: 1000.0,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      // 可以添加更多交易记录
    ];
  }

  Future<void> submitTransaction(Transaction transaction) async {
    // 模拟提交交易记录
    await Future.delayed(const Duration(seconds: 2));
    // 这里可以添加实际的提交交易逻辑，比如调用API
  }
}
