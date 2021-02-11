import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/repositories/fee_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/fee_state.dart';

class FeeCubit extends Cubit<FeeState> {
  FeeRepository _repository;
  FeeCubit(this._repository) : super(FeeLoadingState());

  //get all tutor
  Future getFeeByFeeId(int id) async {
    try {
      Fee fee = await _repository.fetchFeeByFeeId(http.Client(), id);
      emit(FeeLoadedState(fee));
    } catch (e) {
      emit(FeeErrorState('$e'));
    }
  }
}