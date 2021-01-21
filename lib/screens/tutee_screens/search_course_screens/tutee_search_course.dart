import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/course_filter_popup.dart';

class TuteeSearchCourseScreen extends StatefulWidget {
  @override
  _TuteeSearchCourseScreenState createState() =>
      _TuteeSearchCourseScreenState();
}

class _TuteeSearchCourseScreenState extends State<TuteeSearchCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: mainColor,
      height: 220,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
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
          ),
          //Search boxxxx
          Row(
            children: <Widget>[
              SearchBox(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CourseFilterPopup(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Image.asset(
                    'assets/images/ic_filter-horizontal-512.png',
                    height: 23,
                    width: 23,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          //
        ],
      ),
    ));
  }
}

//SEARCH BOX
class SearchBox extends StatelessWidget {
  SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      height: 30,
      width: 300,
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 5,
      ),
      padding: EdgeInsets.only(
        left: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 11),
          icon: Icon(
            Icons.search,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'course, tutor, etc',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
