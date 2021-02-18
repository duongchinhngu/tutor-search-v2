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
