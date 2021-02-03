class Course {
  final int id;
  final String name;
  final String beginTime;
  final String endTime;
  final String studyForm;
  final double studyFee;
  final String daysInWeek;
  final String beginDate;
  final String endDate;
  final String description;
  final String status;
  final int classHasSubjectId;
  final int createdBy;
  final int confirmBy;
  final String createdDate;
  final String confirmedDate;

  Course({this.id, this.name, this.beginTime, this.endTime, this.studyForm, this.studyFee, this.daysInWeek, this.beginDate, this.endDate, this.description, this.status, this.classHasSubjectId, this.createdBy, this.confirmBy, this.createdDate, this.confirmedDate});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      beginTime: json['beginTime'].toString().substring(11),
      endTime: json['endTime'].toString().substring(11),
      studyForm: json['studyForm'],
      studyFee: json['studyFee'].toDouble(),
      daysInWeek: json['daysInWeek'],
      beginDate: json['beginDate'].toString().substring(0,10),
      endDate: json['endDate'].toString().substring(0,10),
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