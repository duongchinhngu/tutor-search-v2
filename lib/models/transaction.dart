abstract class Transaction {
  final int id;
  final String dateTime;
  double amount;
  final double totalAmount;
  final String description;
  final String status;

  Transaction(this.id, this.dateTime, this.amount, this.totalAmount,
      this.description, this.status);

  Transaction.constructor(
      this.id, this.dateTime, this.totalAmount, this.description, this.status);
}
