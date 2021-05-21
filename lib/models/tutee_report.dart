class TuteeReport {
  final int id;
  final int reportTypeId;
  final int enrollmentId;
  final String status;
  final List<String> image;
  final String description;

  TuteeReport(this.id, this.reportTypeId, this.enrollmentId, this.status,
      this.image, this.description);

  TuteeReport.contructor(this.description, this.enrollmentId, this.id,
      this.image, this.reportTypeId, this.status);
}
