class TutorReport {
  final int id;
  final String description;
  final String status;
  final int reportTypeId;
  final int tutorId;
  final List<String> image;

  TutorReport.constructor(this.id, this.description, this.reportTypeId,
      this.tutorId, this.image, this.status);
  TutorReport(
      {this.id,
      this.description,
      this.reportTypeId,
      this.tutorId,
      this.image,
      this.status});
  void showAttributes(TutorReport t) {
    print('thí í tutor report: ' + t.description);
    print('thí í tutor report: ' + t.status);
    print('thí í tutor report: ' + t.reportTypeId.toString());
    print('thí í tutor report: ' + t.tutorId.toString());
    print('thí í tutor report: ' + t.image.toString());
  }
}
