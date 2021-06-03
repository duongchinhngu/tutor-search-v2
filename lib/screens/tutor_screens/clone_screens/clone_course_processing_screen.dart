import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/repositories/course_detail_repository.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/transaction_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_payment/create_course_completed_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_payment/tutor_paid_completed_screen.dart';

import 'clone_course_variables.dart';

class CloneCourseProcessingScreen extends StatelessWidget {
  final TutorTransaction tutorTransaction;
  final Course course;
  final List<CourseDetail> courseDetail;

  const CloneCourseProcessingScreen(
      {Key key, this.course, this.courseDetail, this.tutorTransaction})
      : super(key: key);
  //
  Future<bool> completeTutorPayment(Course course) async {
    //post course
    course.status = StatusConstants.PENDING_STATUS;
    await CourseRepository().postCourse(course);
    //
    ExtendedCourse currentCourse = await CourseRepository()
        .fetchCurrentCourseByTutorId(authorizedTutor.id);
    //
    tutorTransaction.courseId = currentCourse.id;
    await TransactionRepository().postTutorTransaction(tutorTransaction);
    //
    print('===================');
    print(currentCourse.id);
    for (int i = 0; i < courseDetail.length; i++) {
      print(courseDetail[i].schedule);
      print(courseDetail[i].learningOutcome);
      await CourseDetailRepository()
          .postCourseDetail(courseDetail[i], currentCourse.id);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completeTutorPayment(course),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            //reset empty for all field in create course screen
            resetEmptyCloneCourseScreen();
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => TutorPaidCompletedScreen(
                          savePoint: tutorTransaction.archievedPoints,
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
