abstract class Transaction {
  final int id;
  final String dateTime;
  final double amount;
  final double totalAmount;
  final String description;
  final String status;

  Transaction(this.id, this.dateTime, this.amount, this.totalAmount, this.description, this.status);
}