import 'package:tutor_search_system/commons/global_variables.dart' as globals;

import 'extended_models/extended_course.dart';

class Course {
  final int id;
  String name;
  String beginTime;
  String endTime;
  String location;
  double studyFee;
  String daysInWeek;
  String beginDate;
  String endDate;
  String description;
  String status;
  int classHasSubjectId;
  int createdBy;
  String createdDate;
  String confirmedDate;
  int confirmedBy;
  int maxTutee;

  Course.fromJsonConstructor({
    this.id,
    this.name,
    this.beginTime,
    this.endTime,
    this.studyFee,
    this.daysInWeek,
    this.beginDate,
    this.endDate,
    this.description,
    this.status,
    this.classHasSubjectId,
    this.createdBy,
    this.confirmedDate,
    this.createdDate,
    this.confirmedBy,
    this.maxTutee,
    this.location,
  });

  Course(
    this.id,
    this.name,
    this.beginTime,
    this.endTime,
    this.studyFee,
    this.daysInWeek,
    this.beginDate,
    this.endDate,
    this.description,
    this.status,
    this.classHasSubjectId,
    this.createdBy,
    this.maxTutee,
    this.location,
  );

  void showAttributes(ExtendedCourse course) {
    print('name: ' +
        course.name +
        '\nbegin time: ' +
        globals.defaultDatetime +
        'T' +
        course.beginTime +
        '\n Endtime: ' +
        globals.defaultDatetime +
        'T' +
        '\n study fee: ' +
        course.studyFee.toString() +
        '\n days inweek: ' +
        course.daysInWeek +
        '\n begin date: ' +
        course.beginDate +
        '\n end date: ' +
        course.endDate +
        '\n description: ' +
        course.description +
        '\n status: ' +
        course.status +
        '\n classhassubject id: ' +
        course.classHasSubjectId.toString() +
        '\n create by: ' +
        course.createdBy.toString() +
        '\n class name: ' +
        course.className +
        '\n confirmBy by: ' +
        course.confirmedBy.toString());
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course.fromJsonConstructor(
      id: json['id'],
      name: json['name'],
      beginTime: json['beginTime'].toString().substring(11),
      endTime: json['endTime'].toString().substring(11),
      studyFee: json['studyFee'].toDouble(),
      daysInWeek: json['daysInWeek'],
      beginDate: json['beginDate'].toString().substring(0, 10),
      endDate: json['endDate'].toString().substring(0, 10),
      description: json['description'],
      classHasSubjectId: json['classHasSubjectId'],
      createdBy: json['createdBy'],
      status: json['status'],
      confirmedBy: json['confirmedBy'],
      confirmedDate: json['confirmedDate'],
      createdDate: json['createdDate'],
      maxTutee: json['maxTutee'],
      location: json['location'],
    );
  }
}
