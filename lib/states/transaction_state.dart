
abstract class TransactionState {}

class InitialTransactionState extends TransactionState {}

class TransactionCompletedState extends TransactionState {}

class TransactionErrorState extends TransactionState {
  final String errorMessage;

  TransactionErrorState(this.errorMessage);
}

