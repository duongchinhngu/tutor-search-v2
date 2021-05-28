import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/repositories/course_detail_repository.dart';
import 'package:tutor_search_system/states/course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final CourseDetailRepository _repository;
  CourseDetailCubit(this._repository) : super(CourseDetailLoadingState());
}
