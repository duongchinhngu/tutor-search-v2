import 'package:flutter/material.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/home_course_detail.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';

class PreviewCourseScreen extends StatelessWidget {
  final ExtendedCourse course;

  const PreviewCourseScreen({Key key, this.course}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCourseDetailAppbar(context),
      body: buildCourseDetailBody(context, course),
    );
  }
}