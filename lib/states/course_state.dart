import 'package:tutor_search_system/models/course.dart';

abstract class CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadedState {
  final Course course;

  CourseLoadedState(this.course);

}
