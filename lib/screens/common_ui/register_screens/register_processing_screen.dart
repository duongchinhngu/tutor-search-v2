import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/models/account.dart';
import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/repositories/account_repository.dart';
import 'package:tutor_search_system/repositories/tutee_repository.dart';
import 'package:tutor_search_system/screens/common_ui/login_screen.dart';
import 'package:tutor_search_system/screens/common_ui/register_screens/register_variables.dart';

import '../error_screen.dart';

class RegisterProccessingScreen extends StatefulWidget {
  final Tutee tutee;

  const RegisterProccessingScreen({Key key, this.tutee}) : super(key: key);
  @override
  _RegisterProccessingScreenState createState() =>
      _RegisterProccessingScreenState();
}

class _RegisterProccessingScreenState extends State<RegisterProccessingScreen> {
  //
  final tuteeRepository = TuteeRepository();
  //
  final accountRepository = AccountRepository();

  Future<bool> registerTutee(Tutee tutee) async {
    //post course
    await tuteeRepository.postTutee(tutee);
    //init account obj
    final account =
        Account.constructor(0, tutee.email, tutee.roleId, '', 'Active');
    account.showAttribute();
    //post Account
    await accountRepository.postAcount(account);
    return Future.value(true);
  }

  //
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: registerTutee(widget.tutee),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            //reset to defaul value of tuee
            resetRegisterTutee();
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LoginScreen(
                          snackBarIcon: Icons.check_circle_outline_outlined,
                          snackBarTitle: 'Registered successfully',
                          snackBarContent: 'Login to explore now!',
                          snackBarThemeColor: Colors.green.shade600,
                        )),
                ModalRoute.withName('/Home'),
              );
            });
            return Container();
          } else {
            return Container(
              color: backgroundColor,
              child: SpinKitWave(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
