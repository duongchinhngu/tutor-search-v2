import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/tutor_state.dart';

class TutorCubit extends Cubit<TutorState> {
  TutorRepository _repository;
  TutorCubit(this._repository) : super(TutorLoadingState());

  //get all tutor
  Future getTutorByTutorId(int id) async {
    try {
      Tutor tutor = await _repository.fetchTutorByTutorId(http.Client(), id);
      emit(TutorLoadedState(tutor));
    } catch (e) {
      emit(TutorLoadFailedState('$e'));
    }
  }
}
