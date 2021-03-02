import 'package:tutor_search_system/commons/global_variables.dart' as globals;

class Course {
  final int id;
  String name;
  String beginTime;
  String endTime;
  String studyForm;
  double studyFee;
  String daysInWeek;
  String beginDate;
  String endDate;
  String description;
  String status;
  int classHasSubjectId;
  int createdBy;
  int confirmBy;
  String createdDate;
  String confirmedDate;

  Course(
      {this.id,
      this.name,
      this.beginTime,
      this.endTime,
      this.studyForm,
      this.studyFee,
      this.daysInWeek,
      this.beginDate,
      this.endDate,
      this.description,
      this.status,
      this.classHasSubjectId,
      this.createdBy,
      this.confirmBy,
      this.createdDate,
      this.confirmedDate});
  Course.constructor(
      this.id,
      this.name,
      this.beginTime,
      this.endTime,
      this.studyForm,
      this.studyFee,
      this.daysInWeek,
      this.beginDate,
      this.endDate,
      this.description,
      this.status,
      this.classHasSubjectId,
      this.createdBy,
      this.confirmBy,
      this.createdDate,
      this.confirmedDate);

  void showAttributes(Course course) {
    print('name: ' +
        course.name +
        '\nbegin time: ' +
        globals.defaultDatetime +
        'T' +
        course.beginTime +
        '\n Endtime: ' +
        globals.defaultDatetime +
        'T' +
        course.endTime +
        '\n studyForm: ' +
        course.studyForm +
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
        '\n confirmBy: ' +
        course.confirmBy.toString() +
        '\n confirm date: ' +
        course.confirmedDate + '\n Created date: ' + course.createdDate);
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      beginTime: json['beginTime'].toString().substring(11),
      endTime: json['endTime'].toString().substring(11),
      studyForm: json['studyForm'],
      studyFee: json['studyFee'].toDouble(),
      daysInWeek: json['daysInWeek'],
      beginDate: json['beginDate'].toString().substring(0, 10),
      endDate: json['endDate'].toString().substring(0, 10),
      description: json['description'],
      classHasSubjectId: json['classHasSubjectId'],
      createdBy: json['createdBy'],
      status: json['status'],
      confirmBy: json['confirmBy'],
      createdDate: json['createdDate'],
      confirmedDate: json['confirmedDate'],
    );
  }
}
