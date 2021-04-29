import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/membership.dart';
import 'package:tutor_search_system/repositories/membership_repository.dart';
import 'package:tutor_search_system/states/membership_state.dart';

class MembershipCubit extends Cubit<MembershipState> {
  MembershipRepository _repository;
  MembershipCubit(this._repository) : super(MembershipLoadingState());

  //get all tutor
  Future getMembershipByStatus(String status) async {
    try {
      List<Membership> memberships =
          await _repository.fetchMembershipByStatus(status);
      if (memberships != null) {
        emit(MembershipListLoadedState(memberships));
      } else {
        emit(MembershipNoDataState());
      }
    } catch (e) {
      emit(MembershipErrorState('$e'));
    }
  }
}
