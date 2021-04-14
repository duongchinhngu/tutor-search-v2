import 'package:tutor_search_system/models/enrollment_course.dart';

import 'enrollment_state.dart';

class CourseEnrollmentLoadingState extends EnrollmentState {}

class CourseEnrollmentLoadFailedState extends EnrollmentState {
  final String errorMessage;

  CourseEnrollmentLoadFailedState(this.errorMessage);
}

class CourseEnrollmentListLoadedState extends EnrollmentState {
  final List<CourseEnrollment> courseEnrollment;

  CourseEnrollmentListLoadedState(this.courseEnrollment);
}

class CourseEnrollmentListNoDataState extends EnrollmentState {}
