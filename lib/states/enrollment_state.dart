import 'package:tutor_search_system/models/enrollment.dart';

abstract class EnrollmentState {}

class EnrollmentLoadingState extends EnrollmentState {}

class EnrollmentLoadFailedState extends EnrollmentState {
  final String errorMessage;

  EnrollmentLoadFailedState(this.errorMessage);
}

class EnrollmentLoadedState extends EnrollmentState {
  final Enrollment enrollment;

  EnrollmentLoadedState(this.enrollment);
}

class EnrollmentListLoadedState extends EnrollmentState{
  final List<Enrollment> enrollments;

  EnrollmentListLoadedState(this.enrollments);
}