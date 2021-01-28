import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _repository;
  CourseCubit(this._repository) : super(CourseLoadingState());

  Future getAllCourse() async {
    try {
      List<Course> courses = await _repository.fetchAllCourses(http.Client());
      emit(CourseListLoadedState(courses));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }
  //
  Future getCoursesByFilter(String status) async {
    try {
      List<Course> courses = await _repository.fetchCourseByFilter(http.Client(), status);
      emit(CourseListLoadedState(courses));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }
  //get course by course Id
  Future getCoursesByCourseId(int id) async {
    try {
      Course course = await _repository.fetchCourseByCourseId(http.Client(), id);
      emit(CourseLoadedState(course));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }
}
