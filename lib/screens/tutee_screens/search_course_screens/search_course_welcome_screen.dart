import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'subject_grid_screen.dart';

class TuteeSearchCourseWelcomeScreen extends StatefulWidget {
  @override
  _TuteeSearchCourseWelcomeScreenState createState() =>
      _TuteeSearchCourseWelcomeScreenState();
}

class _TuteeSearchCourseWelcomeScreenState
    extends State<TuteeSearchCourseWelcomeScreen> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            //welcome slogan on the toppest
            SearchSloganTitle(),
            //Search boxxxx
            SearchSubjectBox(),
            // //
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: SubjectGridView(),
              ),
            ),
            // SubjectGridScreen(),
          ],
        ),
      ),
    );
  }
}

//slogan
class SearchSloganTitle extends StatelessWidget {
  const SearchSloganTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20, right: 120, top: 30),
      child: Text(
        'Hey! What would you like to learn today?',
        style: GoogleFonts.kaushanScript(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
