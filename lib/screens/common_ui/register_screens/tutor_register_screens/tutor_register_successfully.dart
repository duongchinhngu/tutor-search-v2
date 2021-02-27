import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/repositories/login_repository.dart';
import 'package:tutor_search_system/screens/common_ui/login_screen.dart';

class TutorRegisterSuccessfullyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            //welcome title
            _buildWelcomeLabel(),
            //illustration image
            buildIllustrationImage(),
            //explanation text field
            _buildExtraInformation(),
            // navigating to My Course button
            (authorizedTutor != null)
                ? _buildButton(context)
                : _buildSignOutButton(context),
          ],
        ),
      ),
    );
  }

//back to home button
  InkWell _buildButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            ModalRoute.withName('/Home'),
          );
        });
      },
      child: Container(
        width: 263,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Icon(
                Icons.library_books_rounded,
                size: 30,
                color: textWhiteColor,
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  'Home Screen',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: textWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //logout buton when tutor account status is pending
  InkWell _buildSignOutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        //log out func here
        // signout func
        final loginRepository = LoginRepository();
        await loginRepository.handleSignOut(context);
        //
      },
      child: Container(
        width: 263,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Icon(
                Icons.power_settings_new_rounded,
                size: 30,
                color: textWhiteColor,
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: textWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//extra info
  Widget _buildExtraInformation() {
    return Column(
      children: [
        //
        Container(
          child: Text(
            'Verification is going to complete soon!',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: textGreyColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //explanation text field
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 30,
          ),
          child: Text(
            'Your account status is Pending now!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textFontSize,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Container buildIllustrationImage() {
    return Container(
      padding: EdgeInsets.only(
        top: 0,
        bottom: 20,
      ),
      child: Image.asset(
        'assets/images/education-concept-vector-illustration-in-flat-style-online-education-school-university-creative-ideas.jpg',
      ),
    );
  }

  Container _buildWelcomeLabel() {
    return Container(
      padding: EdgeInsets.only(top: 110, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            size: 30,
            color: Colors.greenAccent[700],
          ),
          Text(
            'Your registration succeeded!',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: textGreyColor,
                fontSize: headerFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
