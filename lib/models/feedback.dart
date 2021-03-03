class Feedbacks {
  final int id;
  final String comment;
  final int tutorId;
  final int tuteeId;
  final double rate;
  final String description;
  final String status;

  Feedbacks({
    this.id,
    this.comment,
    this.tutorId,
    this.description,
    this.status,
    this.tuteeId,
    this.rate,
  });
  Feedbacks.constructor(this.id, this.comment, this.tutorId, this.description,
      this.status, this.tuteeId, this.rate);

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
      id: json['id'],
      comment: json['comment'],
      tutorId: json['tutorId'],
      description: json['description'],
      status: json['status'],
      rate: json['rate'],
      tuteeId: json['tuteeId'],
    );
  }

  void showAttribute() {
    print('Feedbacks comment: ' + comment);
    print('Feedbacks role id: ' + tutorId.toString());
    print('Feedbacks status: ' + status);
  }
}
