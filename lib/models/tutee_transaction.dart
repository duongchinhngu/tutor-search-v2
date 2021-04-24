import 'package:tutor_search_system/models/transaction.dart';

class TuteeTransaction extends Transaction {
  final int tuteeId;
  final int commissionId;
  String commissionName;
  final int courseId;
  String courseName;
  final double studyFee;
  final double commissionRate;

  TuteeTransaction.modelConstructor(
    int id,
    String dateTime,
    // double amount,
    double totalAmount,
    String description,
    String status,
    this.tuteeId,
    this.commissionId,
    this.courseId,
    this.studyFee,
    this.commissionRate,
  ) : super.constructor(id, dateTime, totalAmount, description, status);

  TuteeTransaction({
    int id,
    String dateTime,
    // double amount,
    double totalAmount,
    String description,
    String status,
    this.tuteeId,
    this.commissionId,
    this.commissionName,
    this.courseId,
    this.courseName,
    this.studyFee,
    this.commissionRate,
  }) : super.constructor(id, dateTime, totalAmount, description, status);

  factory TuteeTransaction.fromJson(Map<String, dynamic> json) {
    return TuteeTransaction(
      id: json['id'],
      dateTime:
          json['dateTime'].toString().substring(0, 19).replaceFirst('T', ' '),
      // amount: json['amount'].toDouble(),
      totalAmount: json['totalAmount'].toDouble(),
      description: json['description'],
      status: json['status'],
      tuteeId: json['tuteeId'],
      commissionId: json['commissionId'],
      commissionName: json['commissionName'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      studyFee: json['studyFee'].toDouble(),
      commissionRate: json['commissionRate'].toDouble(),
    );
  }
}
