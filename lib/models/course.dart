import 'dart:ffi';

class Course {
  final int id;
  final String name;
  final String time;
  final String studyForm;
  final Float studyFee;
  final String daysInWeek;
  final DateTime beginDate;
  final DateTime endDate;
  final String description;
  final String status;
  final int subjectId;
  final int createdBy;
  final int confirmBy;
  final DateTime createdDate;
  final DateTime confirmedDate;

  Course({this.id, this.name, this.time, this.studyForm, this.studyFee, this.daysInWeek, this.beginDate, this.endDate, this.description, this.status, this.subjectId, this.createdBy, this.confirmBy, this.createdDate, this.confirmedDate});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      time: json['time'],
      studyForm: json['studyForm'],
      studyFee: json['studyFee'],
      daysInWeek: json['daysInWeek'],
      beginDate: json['beginDate'],
      endDate: json['endDate'],
      description: json['description'],
      subjectId: json['subjectId'],
      createdBy: json['createdBy'],
      status: json['status'],
      confirmBy: json['confirmBy'],
      createdDate: json['createdDate'],
      confirmedDate: json['confirmedDate'],
    );
  }
}