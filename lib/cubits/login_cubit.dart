import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/person.dart';
import 'package:tutor_search_system/repositories/login_repository.dart';
import 'package:tutor_search_system/states/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;
  LoginCubit(this.loginRepository) : super(InitialLoginState());

  // route to proper role
  Future routeRole(String email) async {
    try {
      Person person = await loginRepository.fetchPersonByEmail(email);
      emit(SignInSucceededState(person));
    } catch (e) {
      emit(SignedInFailedState('$e'));
    }
  }
}
