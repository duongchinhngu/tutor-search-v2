import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/course_filter_variables.dart';
import 'package:tutor_search_system/states/course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _repository;
  CourseCubit(this._repository) : super(CourseLoadingState());

  //get courses for tutee home screen;
  //course status = active; not registered by this authorized tutee id
  Future getTuteeHomeCourses() async {
    try {
      List<Course> courses =
          await _repository.fecthTuteeHomeCourses(http.Client());
      emit(CourseListLoadedState(courses));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  //
  Future getCoursesByFilter(Filter filter) async {
    try {
      List<Course> courses = await _repository.fetchCourseByFilter(
          http.Client(), filter);
      emit(CourseListLoadedState(courses));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  // //get courses unregisterd by tuteeId; by subjectId and classId
  // Future getUnregisteredCoursesBySubjectIdClassId(int tuteeId, int subjectId, int classId) async {
  //   try {
  //     List<Course> courses = await _repository.fetchgetUnregisteredCoursesBySubjectIdClassId(
  //         http.Client(), tuteeId, subjectId, classId);
  //     emit(CourseListLoadedState(courses));
  //   } catch (e) {
  //     emit(CourseLoadFailedState('$e'));
  //   }
  // }

  //get course by course Id
  Future getCoursesByCourseId(int id) async {
    try {
      Course course =
          await _repository.fetchCourseByCourseId(http.Client(), id);
      emit(CourseLoadedState(course));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  //get all course by tuteeId
  //get course by course Id
  Future getCoursesByEnrollmentStatus(int tuteeId, String status) async {
    try {
      List<Course> courses;
      if (status == 'All') {
        courses =
            await _repository.fetchCoursesByTuteeId(http.Client(), tuteeId);
      } else {
        courses = await _repository.fetchCoursesByEnrollmentStatus(
            http.Client(), status, tuteeId);
      }

      emit(CourseListLoadedState(courses));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }
}
