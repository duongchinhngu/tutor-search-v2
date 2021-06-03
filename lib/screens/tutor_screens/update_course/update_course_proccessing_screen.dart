import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/repositories/course_detail_repository.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_payment/create_course_completed_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/update_course/update_course_variables.dart';

class UpdateCourseProcessingScreen extends StatelessWidget {
  final Course course;
  final List<CourseDetail> courseDetail;

  const UpdateCourseProcessingScreen({Key key, this.course, this.courseDetail})
      : super(key: key);
  //
  Future<bool> updateCouse(
      Course course, List<CourseDetail> courseDetail) async {
    //put courses
    await CourseRepository().putCourse(course);
    //put course details
    for (var d in courseDetail) {
      //
      await CourseDetailRepository().putCourseDetail(d);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateCouse(course, courseDetail),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            //reset empty for all field in create course screen
            resetEmptyUpdateCourseScreen();
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => CreateCourseCompletedScreen()),
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
