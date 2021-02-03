import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/states/enrollment_state.dart';

class EnrollmentCubit extends Cubit<EnrollmentState> {
  final EnrollmentRepository _repository;
  EnrollmentCubit(this._repository) : super(EnrollmentLoadingState());
  
  
}