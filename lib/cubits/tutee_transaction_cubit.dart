import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/repositories/tutee_transaction_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/tutee_transaction_state.dart';

class TuteeTransactionCubit extends Cubit<TuteeTransactionState> {
  final TuteeTransactionRepository _repository;
  TuteeTransactionCubit(this._repository)
      : super(InitialTuteeTransactionState());

  //get all active class by subject id
  Future getTuteeTransactionByTuteeId(int tuteeId) async {
    try {
      List<TuteeTransaction> tuteeTransactiones = await _repository
          .fetchTuteeTransactionByTuteeId(http.Client(), tuteeId);
      if (tuteeTransactiones == null) {
        emit(TuteeTransactionNoDataState());
      } else {
        emit(TuteeTransactionListLoadedState(tuteeTransactiones));
      }
    } catch (e) {
      emit(TuteeTransactionErrorState('$e'));
    }
  }
}
