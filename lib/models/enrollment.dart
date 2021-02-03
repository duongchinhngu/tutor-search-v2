class Enrollment {
  final int id;
  final int tuteeId;
  final int courseId;
  final String description;
  final String status;

  Enrollment.modelConstructor(
      this.id, this.tuteeId, this.courseId, this.description, this.status);

  Enrollment(
      {this.id, this.tuteeId, this.courseId, this.description, this.status});

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      tuteeId: json['tuteeId'],
      courseId: json['courseId'],
      description: json['description'],
      status: json['status'],
    );
  }
}
