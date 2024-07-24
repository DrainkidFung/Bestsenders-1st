class Transaction {
  final String transactionId;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.transactionId,
    required this.description,
    required this.amount,
    required this.date,
  });
}
