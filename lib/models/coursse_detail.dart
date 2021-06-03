class CourseDetail {
  int id;
  String period;
  String schedule;
  String learningOutcome;
  int courseId;

  CourseDetail(
    this.period,
    this.schedule,
    this.learningOutcome,
    this.id,
    this.courseId,
  );

  CourseDetail.weekOutcome(this.period, this.learningOutcome);

  CourseDetail.weekPlan(this.period, this.schedule);

  CourseDetail.jsonConstructor({
    this.period,
    this.schedule,
    this.learningOutcome,
    this.id,
    this.courseId,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail.jsonConstructor(
      id: json['id'],
      period: json['period'],
      courseId: json['courseId'],
      schedule: json['schedule'],
      learningOutcome: json['learningOutcome'],
    );
  }

  void showAttributes(CourseDetail c) {
    print('id: ' + c.id.toString());
    print('period: ' + c.period);
    print('courseId: ' + c.courseId.toString());
    print('schedule: ' + c.schedule);
    print('learningOutcome: ' + c.learningOutcome);
  }
}
