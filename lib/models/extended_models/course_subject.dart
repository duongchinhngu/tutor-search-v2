import '../course.dart';

class ExtendedCourse extends Course {
  final String className;
  final String subjectName;

  ExtendedCourse(
      int id,
      String name,
      String beginTime,
      String endTime,
      String studyForm,
      double studyFee,
      String daysInWeek,
      String beginDate,
      String endDate,
      String description,
      String status,
      int classHasSubjectId,
      int createdBy,
      String createdDate,
      String confirmedDate,
      int confirmedBy,
      int maxTutee,
      this.className,
      this.subjectName)
      : super(
          id,
          name,
          beginTime,
          endTime,
          studyForm,
          studyFee,
          daysInWeek,
          beginDate,
          endDate,
          description,
          status,
          classHasSubjectId,
          createdBy,
          maxTutee,
        );

  ExtendedCourse.fromJsonConstructor({
    int id,
    String name,
    String beginTime,
    String endTime,
    String studyForm,
    double studyFee,
    String daysInWeek,
    String beginDate,
    String endDate,
    String description,
    String status,
    int classHasSubjectId,
    int createdBy,
    String createdDate,
    String confirmedDate,
    int confirmedBy,
    int maxTutee,
    this.className,
    this.subjectName,
  }) : super(
          id,
          name,
          beginTime,
          endTime,
          studyForm,
          studyFee,
          daysInWeek,
          beginDate,
          endDate,
          description,
          status,
          classHasSubjectId,
          createdBy,
          maxTutee,
        );

  factory ExtendedCourse.fromJson(Map<String, dynamic> json) {
    return ExtendedCourse.fromJsonConstructor(
      id: json['id'],
      status: json['status'],
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
      confirmedBy: json['confirmedBy'],
      confirmedDate: json['confirmedDate'],
      createdDate: json['createdDate'],
      maxTutee: json['maxTutee'],
      className: json['className'],
      subjectName: json['subjectName'],
    );
  }
}
