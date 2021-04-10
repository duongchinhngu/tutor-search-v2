class CourseEnrollment {
  final int id;
  final int tuteeId;
  final int courseId;
  final String description;
  String status;
  String createdDate;
  double studyFee;
  String courseName;
  String tuteeName;

  CourseEnrollment.modelContructor(this.id, this.tuteeId, this.courseId,
      this.description, this.status, this.createdDate);

  CourseEnrollment(
      {this.id,
      this.tuteeId,
      this.courseId,
      this.description,
      this.status,
      this.studyFee,
      this.createdDate,
      this.courseName,
      this.tuteeName});

  factory CourseEnrollment.fromJson(Map<String, dynamic> json) {
    return CourseEnrollment(
      id: json['id'],
      courseId: json['courseId'],
      courseName: json['courseName'],
      createdDate: json['createdDate'],
      description: json['description'],
      status: json['status'],
      studyFee: json['studyFee'].toDouble(),
      tuteeId: json['tuteeId'],
      tuteeName: json['tuteeName'],
    );
  }
}
