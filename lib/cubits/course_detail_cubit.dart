import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/repositories/course_detail_repository.dart';
import 'package:tutor_search_system/states/course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final CourseDetailRepository _repository;
  CourseDetailCubit(this._repository) : super(CourseDetailLoadingState());

  Future getByCourseId(int courseId) async {
try {
      List<CourseDetail> schedules = await _repository.fetchScheduleByCourseId(courseId);
      emit(CourseDetailListLoadedState(schedules));
    } catch (e) {
      emit(CourseDetailLoadFailedState('$e'));
    }
  }
}
