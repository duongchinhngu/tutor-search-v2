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

  CourseDetail.jsonConstructor({
    this.period,
    this.schedule,
    this.learningOutcome,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail.jsonConstructor(
      period: json['period'],
      schedule: json['schedule'],
      learningOutcome: json['learningOutcome'],
    );
  }
}
