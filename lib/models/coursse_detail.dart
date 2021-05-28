class CourseDetail {
  String period;
  String schedule;
  String learningOutcome;

  CourseDetail(
    this.period,
    this.schedule,
    this.learningOutcome,
  );

  CourseDetail.weekOutcome(this.period, this.learningOutcome);

  CourseDetail.weekPlan(this.period, this.schedule);
}
