import 'package:tutor_search_system/models/transaction.dart';

class TutorTransaction extends Transaction {
  int archievedPoints;
  final int usedPoints;
  final int feeId;
  final int tutorId;
  final double feePrice;
  String feeName;
  int courseId;

  TutorTransaction.modelConstructor(
      int id,
      String dateTime,
      double amount,
      double totalAmount,
      String description,
      String status,
      this.feeId,
      this.archievedPoints,
      this.usedPoints,
      this.tutorId,
      this.feePrice,
      this.courseId)
      : super(id, dateTime, amount, totalAmount, description, status);

  TutorTransaction({
    int id,
    String dateTime,
    double amount,
    double totalAmount,
    String description,
    String status,
    this.archievedPoints,
    this.usedPoints,
    this.tutorId,
    this.feeId,
    this.feePrice,
    this.feeName,
    this.courseId,
  }) : super(id, dateTime, amount, totalAmount, description, status);

  factory TutorTransaction.fromJson(Map<String, dynamic> json) {
    return TutorTransaction(
      id: json['id'],
      dateTime: json['dateTime'],
      amount: json['amount'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
      description: json['description'],
      status: json['status'],
      tutorId: json['tutorId'],
      feeId: json['feeId'],
      archievedPoints: json['archievedPoints'],
      usedPoints: json['usedPoints'],
      feePrice: json['feePrice'].toDouble(),
      feeName: json['feeName'],
      courseId: json['courseId'],
    );
  }
}
