import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/enrollment_course.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/states/courseenrollment_state.dart';
import 'package:tutor_search_system/states/enrollment_state.dart';

class EnrollmentCubit extends Cubit<EnrollmentState> {
  final EnrollmentRepository _repository;
  EnrollmentCubit(this._repository) : super(EnrollmentLoadingState());

  //get all active class
  Future getEnrollmentByCourseIdTuteeId(int courseId, int tuteeId) async {
    try {
      Enrollment enrollment =
          await _repository.fetchEnrollmentByCourseIdTuteeId(courseId, tuteeId);
      emit(EnrollmentLoadedState(enrollment));
    } catch (e) {
      emit(EnrollmentLoadFailedState('$e'));
    }
  }

  Future getEnrollmentOfMonthByTutorIdDate(
      int tutorId, String currentdate) async {
    try {
      CourseEnrollment courseEnrollment = await _repository
          .fetchCourseEnrollmentByTutorIdForMonth(tutorId, currentdate);
      emit(CourseEnrollmentListLoadedState(courseEnrollment));
    } catch (e) {
      emit(CourseEnrollmentLoadFailedState('$e'));
    }
  }
}
