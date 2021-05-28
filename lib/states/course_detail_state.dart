import 'package:tutor_search_system/models/coursse_detail.dart';

abstract class CourseDetailState {}

class CourseDetailLoadingState extends CourseDetailState {}

class CourseDetailLoadFailedState extends CourseDetailState {
  final String errorMessage;
  CourseDetailLoadFailedState(this.errorMessage);
}

class CourseDetailLoadedState extends CourseDetailState {
  final CourseDetail courseDetail;

  CourseDetailLoadedState(this.courseDetail);
}

class CourseDetailListLoadedState extends CourseDetailState {
  List<CourseDetail> listCourseDetail;

  CourseDetailListLoadedState(this.listCourseDetail);
}
