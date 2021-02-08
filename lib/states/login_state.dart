import 'package:tutor_search_system/models/person.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class SigingInState extends LoginState {}

class SignInSucceededState extends LoginState {
  final Person person;

  SignInSucceededState(this.person);
}

class SignedInFailedState extends LoginState {
  final String errorMessage;

  SignedInFailedState(this.errorMessage);
}
