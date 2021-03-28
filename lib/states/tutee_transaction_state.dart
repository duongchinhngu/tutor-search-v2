import 'package:tutor_search_system/models/tutee_transaction.dart';

abstract class TuteeTransactionState {}

class InitialTuteeTransactionState extends TuteeTransactionState {}

class TuteeTransactionErrorState extends TuteeTransactionState {
  final String errorMessage;

  TuteeTransactionErrorState(this.errorMessage);
}

class TuteeTransactionLoadedState extends TuteeTransactionState {
  final TuteeTransaction tuteeTransaction;

  TuteeTransactionLoadedState(this.tuteeTransaction);
}

class TuteeTransactionListLoadedState extends TuteeTransactionState {
  final List<TuteeTransaction> tuteeTransactions;

  TuteeTransactionListLoadedState(this.tuteeTransactions);
}

class TuteeTransactionNoDataState extends TuteeTransactionState {}
