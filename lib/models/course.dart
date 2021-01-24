class Course {
  final int id;
  final String name;
  final String studyTime;
  final String studyForm;
  final double studyFee;
  final String daysInWeek;
  final String beginDate;
  final String endDate;
  final String description;
  final String status;
  final int subjectId;
  final int createdBy;
  final int confirmBy;
  final String createdDate;
  final String confirmedDate;

  Course({this.id, this.name, this.studyTime, this.studyForm, this.studyFee, this.daysInWeek, this.beginDate, this.endDate, this.description, this.status, this.subjectId, this.createdBy, this.confirmBy, this.createdDate, this.confirmedDate});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      studyTime: json['studyTime'],
      studyForm: json['studyForm'],
      studyFee: json['studyFee'].toDouble(),
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