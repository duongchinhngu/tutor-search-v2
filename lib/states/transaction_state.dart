import 'package:tutor_search_system/models/tutee_transaction.dart';

abstract class TransactionState {}

class InitialTransactionState extends TransactionState {}

class TransactionCompletedState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  final String errorMessage;

  TransactionErrorState(this.errorMessage);
}

