import 'package:tutor_search_system/models/transaction.dart';

class TuteeTransaction extends Transaction {
  final int tuteeId;
  final int feeId;

  TuteeTransaction.modelConstructor(
      int id,
      String dateTime,
      double amount,
      double totalAmount,
      String description,
      String status,
      this.tuteeId,
      this.feeId)
      : super(id, dateTime, amount, totalAmount, description, status);

  TuteeTransaction(
      {int id,
      String dateTime,
      double amount,
      double totalAmount,
      String description,
      String status,
      this.tuteeId,
      this.feeId})
      : super(id, dateTime, amount, totalAmount, description, status);

  factory TuteeTransaction.fromJson(Map<String, dynamic> json) {
    return TuteeTransaction(
      id: json['id'],
      dateTime: json['dateTime'],
      amount: json['amount'],
      totalAmount: json['totalAmount'],
      description: json['description'],
      status: json['status'],
      tuteeId: json['tuteeId'],
      feeId: json['feeId'],
    );
  }
}
