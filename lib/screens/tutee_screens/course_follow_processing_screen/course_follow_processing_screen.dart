import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_payment/follow_completed_screen.dart';

class CourseFollowProcessingScreen extends StatefulWidget {
  final Enrollment enrollment;

  const CourseFollowProcessingScreen({Key key, @required this.enrollment})
      : super(key: key);
  @override
  _CourseFollowProcessingScreenState createState() =>
      _CourseFollowProcessingScreenState();
}

class _CourseFollowProcessingScreenState
    extends State<CourseFollowProcessingScreen> {
  Future<bool> completeFollowCourse(Enrollment enrollment) async {
    await EnrollmentRepository().postEnrollment(enrollment);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completeFollowCourse(widget.enrollment),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => FollowCompletedScreen()),
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
