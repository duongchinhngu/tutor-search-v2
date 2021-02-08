import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/cubits/login_cubit.dart';
import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/login_repository.dart';
import 'package:tutor_search_system/screens/common_ui/splash_screen.dart';
import 'package:tutor_search_system/screens/common_ui/tutee_wrapper.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_home_screen.dart';
import 'package:tutor_search_system/states/login_state.dart';

class RoleRouter extends StatelessWidget {
  final String userEmail;

  const RoleRouter({Key key, @required this.userEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository()),
      child: BlocBuilder<LoginCubit, LoginState>(
        // ignore: missing_return
        builder: (context, state) {
          //
          final loginCubit = context.watch<LoginCubit>();
          loginCubit.routeRole(userEmail);
          //
          if (state is InitialLoginState) {
            return SplashScreen();
          } else if (state is SignedInFailedState) {
            return Container(
              child: Center(
                child: Text('this error: ' + state.errorMessage),
              ),
            );
          } else if (state is SignInSucceededState) {
            if (state.person is Tutor) {
              //remove all screen stack and navigate
              WidgetsBinding.instance.addPostFrameCallback((_) {
                return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => TutorHomeScreen(),
                  ),
                );
              });
            } else if (state.person is Tutee) {
              //remove all screen stack and navigate
              WidgetsBinding.instance.addPostFrameCallback((_) {
                return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => TuteeBottomNavigatorBar(
                      tuteeId: state.person.id,
                    ),
                  ),
                );
              });
            }
            return SplashScreen();
          }
        },
      ),
    );
    // // //
    // final user = Provider.of<Person>(context);
    // //
    // if (user == null) {
    //   return LoginScreen();
    // } else if (user.email == 'duongchinhngu@gmail.com') {
    //   return TuteeBottomNavigatorBar();
    // } else if (user.email == 'ngudc@gmail.com') {
    //   return TuteeHomeScreen();
    // }
    // return Scaffold(
    //   body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
    //     //
    //     final loginCubit = context.watch<LoginCubit>();
    //     loginCubit.loginByGoolge();
    //     //
    //     if (state is InitialLoginState) {
    //       return Center(child: FlutterLogo());
    //     } else if (state is SignedInFailedState) {
    //       return Center(
    //         child: Text(state.errorMessage),
    //       );
    //     } else if (state is SignInSucceededState) {
    //       return TuteeBottomNavigatorBar();
    //     }
    //   }),
    // );
  }
}
