import 'package:tutor_search_system/models/tutor_transaction.dart';

abstract class TutorTransactionState {}

class InitialTutorTransactionState extends TutorTransactionState {}

class TutorTransactionErrorState extends TutorTransactionState {
  final String errorMessage;

  TutorTransactionErrorState(this.errorMessage);
}

class TutorTransactionLoadedState extends TutorTransactionState {
  final TutorTransaction tutorTransaction;

  TutorTransactionLoadedState(this.tutorTransaction);
}

class TutorTransactionListLoadedState extends TutorTransactionState {
  final List<TutorTransaction> tutorTransactions;

  TutorTransactionListLoadedState(this.tutorTransactions);
}

class TutorTransactionNoDataState extends TutorTransactionState {}
