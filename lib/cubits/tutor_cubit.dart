import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/models/extended_models/extended_tutor.dart';
import 'package:tutor_search_system/repositories/membership_repository.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/tutor_state.dart';

class TutorCubit extends Cubit<TutorState> {
  TutorRepository _repository;
  TutorCubit(this._repository) : super(TutorLoadingState());

  //get tutor
  Future getTutorByTutorId(int id) async {
    try {
      ExtendedTutor tutor =
          await _repository.fetchTutorByTutorId(http.Client(), id);
      //
      await MembershipRepository()
          .fetchMembershipByMembershipId(http.Client(), tutor.membershipId)
          .then((value) {
        membershipName = value.name;
      });
      //
      emit(ExtendedTutorLoadedState(tutor));
    } catch (e) {
      emit(TutorLoadFailedState('$e'));
    }
  }
}
