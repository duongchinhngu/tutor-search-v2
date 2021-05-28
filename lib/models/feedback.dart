class Feedbacks {
  final int id;
  final String comment;
  final int tutorId;
  final int tuteeId;
  final double rate;
  String tuteeName;
  String tuteeAvatarUrl;
  final String status;
  String createdDate;
  final int courseId;
  String className;
  String subjectName;

  Feedbacks({
    this.id,
    this.comment,
    this.tutorId,
    this.createdDate,
    this.status,
    this.tuteeId,
    this.rate,
    this.tuteeName,
    this.tuteeAvatarUrl,
    this.courseId,
    this.className,
    this.subjectName,
    // this.confirmedDate,
    // this.confirmedBy,
  });
  Feedbacks.constructor(
    this.id,
    this.comment,
    this.tutorId,
    // this.createdDate,
    this.status,
    this.tuteeId,
    this.rate,
    this.courseId,
    // this.confirmedDate,
    // this.confirmedBy,
  );

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
      id: json['id'],
      comment: json['comment'],
      tutorId: json['tutorId'],
      createdDate: json['createdDate'],
      rate: json['rate'].toDouble(),
      tuteeId: json['tuteeId'],
      status: json['status'],
      tuteeName: json['tuteeName'],
      tuteeAvatarUrl: json['tuteeAvatarUrl'],
      courseId: json['courseId'],
      className: json['className'],
      subjectName: json['subjectName'],
    );
  }

  void showAttribute() {
    print('Feedbacks comment: ' + comment);
    print('Feedbacks role id: ' + tutorId.toString());
    print('Feedbacks status: ' + status);
  }
}
