import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/role_router.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';

import 'common_ui/tutee_wrapper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  @override
  void initState() {
    super.initState();
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: googleSignIn.isSignedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              alignment: Alignment.center,
              height: double.infinity,
              color: backgroundColor,
              child: Column(
                children: <Widget>[
                  //welcome title
                  Container(
                    padding: EdgeInsets.only(top: 120, bottom: 30),
                    child: Text(
                      'Welcome to \nEasy Education App',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        textStyle: TextStyle(
                          color: textGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //illustration image
                  Container(
                    padding: EdgeInsets.only(
                      top: 0,
                      bottom: 30,
                    ),
                    child: Image.asset(
                      'assets/images/boy-studying-with-book_113065-238.jpg',
                      // width: 100,
                    ),
                  ),
                  // google login buotton
                  InkWell(
                    onTap: () async {
                      // GoogleSignInAccount currentUser =
                      //     await loginRepository.handleSignInGoogle();
                      // print('this is raw user: ' + currentUser.email);
                      // if (currentUser == null) {
                      //   return LoginScreen();
                      // } else {
                      //   return TuteeHomeScreen();
                      // }

                      await googleSignIn.signIn().whenComplete(() async {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RoleRouter(
                              userEmail: googleSignIn.currentUser.email,
                            ),
                          ),
                        );
                      });
                    },
                    child: Container(
                      width: 263,
                      height: 43,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red[900],
                      ),
                      child: Text(
                        'GOOGLE',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textWhiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //sign up link
                  InkWell(
                    onTap: null,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: const Color(0xff2B2BAA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return buildLoadingIndicator();
          }
        },
      ),
    );
  }
}
