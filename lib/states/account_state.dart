import 'package:tutor_search_system/models/account.dart';

abstract class AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadFailedState extends AccountState {
  final String errorMessage;

  AccountLoadFailedState(this.errorMessage);
}

class AccountLoadedState extends AccountState {
  final Account account;

  AccountLoadedState(this.account);
}
