import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/models/extended_models/course_tutor.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/filter_models/course_filter_variables.dart';
import 'package:tutor_search_system/states/course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _repository;
  CourseCubit(this._repository) : super(CourseLoadingState());

  //get courses for tutee home screen;
  //course status = active; not registered by this authorized tutee id
  Future getTuteeHomeCourses(String currentAddress) async {
    try {
      if (currentAddress == '') {
        emit(CourseLoadingState());
      } else {
        List<CourseTutor> courses = await _repository.fecthTuteeHomeCourses(
            http.Client(), currentAddress);
        if (courses != null) {
          emit(CourseTutorListLoadedState(courses));
        } else {
          emit(CourseNoDataState());
        }
      }
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  //
  Future getCoursesByFilter(Filter filter, String currentAddress) async {
    try {
      List<CourseTutor> courses =
          await _repository.fetchCourseByFilter(http.Client(), filter, currentAddress);
      if (courses != null) {
        emit(CourseTutorListLoadedState(courses));
      } else {
        emit(CourseNoDataState());
      }
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
      ExtendedCourse course =
          await _repository.fetchCourseByCourseId(http.Client(), id);
      emit(CourseLoadedState(course));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  Future getCoursesByCourseIdTuteeId(int id, int tuteeId) async {
    try {
      ExtendedCourse course = await _repository.fetchCourseByCourseIdTuteeId(
          http.Client(), id, tuteeId);
      emit(CourseLoadedState(course));
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  //get all course by tuteeId
  //get course by course Id
  Future getCoursesByEnrollmentStatus(int tuteeId, String status) async {
    try {
      List<ExtendedCourse> courses;
      courses = await _repository.fetchCoursesByEnrollmentStatus(
          http.Client(), status, tuteeId);
      if (courses == null) {
        emit(CourseNoDataState());
      } else {
        emit(ExtendedCourseListLoadedState(courses));
      }
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }

  //get all course by tutorId
  //get course by course Id
  Future getTutorCoursesByCourseStatus(int tutorId, String status) async {
    try {
      List<Course> courses = await _repository.fetchTutorCoursesByCourseStatus(
          http.Client(), status, tutorId);
      //check whether result has data
      if (courses != null) {
        emit(CourseListLoadedState(courses));
      } else {
        emit(CourseNoDataState());
      }
    } catch (e) {
      emit(CourseLoadFailedState('$e'));
    }
  }
}
