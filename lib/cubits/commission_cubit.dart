import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/commission.dart';
import 'package:tutor_search_system/repositories/commission_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/commission_state.dart';

class CommissionCubit extends Cubit<CommissionState> {
  CommissionRepository _repository;
  CommissionCubit(this._repository) : super(CommissionLoadingState());

  //get all tutor
  Future getCommissionByCommissionId(int id) async {
    try {
      Commission commission = await _repository.fetchCommissionByCommissionId(http.Client(), id);
      emit(CommissionLoadedState(commission));
    } catch (e) {
      emit(CommissionErrorState('$e'));
    }
  }
}