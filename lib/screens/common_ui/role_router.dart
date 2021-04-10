import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/cubits/login_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/login_repository.dart';
import 'package:tutor_search_system/repositories/membership_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/splash_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_wrapper.dart';
import 'package:tutor_search_system/screens/common_ui/login_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_register_screens/tutor_register_successfully.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_wrapper.dart';
import 'package:tutor_search_system/states/login_state.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;

class RoleRouter extends StatefulWidget {
  final String userEmail;

  const RoleRouter({Key key, @required this.userEmail}) : super(key: key);

  @override
  _RoleRouterState createState() => _RoleRouterState();
}

class _RoleRouterState extends State<RoleRouter> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepository()),
      child: BlocBuilder<LoginCubit, LoginState>(
        // ignore: missing_return
        builder: (context, state) {
          //
          final loginCubit = context.watch<LoginCubit>();
          loginCubit.routeRole(widget.userEmail);
          //
          if (state is InitialLoginState) {
            return SplashScreen();
          } else if (state is SignedInFailedState) {
            return ErrorScreen();
          } else if (state is SignInSucceededState) {
            if (state.person == null ||
                state.person.status ==
                    globals.StatusConstants.INACTIVE_STATUS) {
              //remove all screen stack and navigate
              WidgetsBinding.instance.addPostFrameCallback((_) {
                return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      snackBarIcon: Icons.error_outline,
                      snackBarContent: "Invalid Email! Please try again!",
                      snackBarThemeColor: Colors.red[900],
                      snackBarTitle: 'Error',
                    ),
                  ),
                );
              });
            } else if (state.person is Tutor) {
              //set authorized Tutor
              globals.authorizedTutor = state.person;
              if (globals.authorizedTutor.status == 'Pending') {
                //remove all screen stack and navigate
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TutorRegisterSuccessfullyScreen(),
                    ),
                  );
                });
              } else if (globals.authorizedTutor.status == 'Active') {
                //get membership and take name
                MembershipRepository()
                    .fetchMembershipByMembershipId(
                        http.Client(), globals.authorizedTutor.membershipId)
                    .then((membership) {
                  print('thí í memershoo: ' + membership.name);
                  membershipName = membership.name;
                });

                //remove all screen stack and navigate
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TutorBottomNavigatorBar(),
                    ),
                  );
                });
              } else if (globals.authorizedTutor.status ==
                  StatusConstants.INACTIVE_STATUS) {
                //remove all screen stack and navigate
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TutorRegisterSuccessfullyScreen(),
                    ),
                  );
                });
              }
            } else if (state.person is Tutee) {
              //set authorized tutee
              globals.authorizedTutee = state.person;
              //remove all screen stack and navigate
              WidgetsBinding.instance.addPostFrameCallback((_) {
                return Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => TuteeBottomNavigatorBar(),
                  ),
                );
              });
            }
            return SplashScreen();
          }
        },
      ),
    );
  }
}
