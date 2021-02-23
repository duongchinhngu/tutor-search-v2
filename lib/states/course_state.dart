import 'package:tutor_search_system/models/course.dart';

abstract class CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadFailedState extends CourseState {
  final String errorMessage;

  CourseLoadFailedState(this.errorMessage);
}

class CourseLoadedState extends CourseState {
  final Course course;

  CourseLoadedState(this.course);
}

class CourseListLoadedState extends CourseState{
  List<Course> courses;

  CourseListLoadedState(this.courses);
}
