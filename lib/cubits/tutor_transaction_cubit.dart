import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/repositories/tutor_transaction_repository.dart';
import 'package:tutor_search_system/states/tutor_transaction_state.dart';

class TutorTransactionCubit extends Cubit<TutorTransactionState> {
  final TutorTransactionRepository _repository;
  TutorTransactionCubit(this._repository)
      : super(InitialTutorTransactionState());

  //get all active class by subject id
  Future getTutorTransactionByTutorId(int tutorId) async {
    try {
      List<TutorTransaction> tutorTransactiones = await _repository
          .fetchTutorTransactionByTutorId(http.Client(), tutorId);
      if (tutorTransactiones == null) {
        emit(TutorTransactionNoDataState());
      } else {
        emit(TutorTransactionListLoadedState(tutorTransactiones));
      }
    } catch (e) {
      emit(TutorTransactionErrorState('$e'));
    }
  }
}
