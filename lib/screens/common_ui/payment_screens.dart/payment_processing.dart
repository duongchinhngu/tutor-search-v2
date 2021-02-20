import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/repositories/transaction_repository.dart';
import 'package:tutor_search_system/screens/common_ui/payment_screens.dart/result_screens/follow_completed_screen.dart';
import '../error_screen.dart';
import 'result_screens/create_course_completed_screen.dart';

//tutee payment processing screen
//this screen process payment; navigate to result screen (error, complete successully; processing)
class TuteePaymentProccessingScreen extends StatefulWidget {
  final TuteeTransaction tuteeTransaction;
  final Enrollment enrollment;

  const TuteePaymentProccessingScreen(
      {Key key, @required this.tuteeTransaction, @required this.enrollment})
      : super(key: key);
  @override
  _TuteePaymentProccessingScreenState createState() =>
      _TuteePaymentProccessingScreenState();
}

class _TuteePaymentProccessingScreenState
    extends State<TuteePaymentProccessingScreen> {
  final tuteeTransactionRepository = TransactionRepository();
  final enrollmentRepository = EnrollmentRepository();

  // enrollmentRepository.postEnrollment(enrollment);

  Future<bool> completePayment(
      TuteeTransaction tuteeTransaction, Enrollment enrollment) async {
    await tuteeTransactionRepository
        .postTuteeTransaction(widget.tuteeTransaction);
    await enrollmentRepository.postEnrollment(enrollment);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completePayment(widget.tuteeTransaction, widget.enrollment),
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

//tutor payment processing screen
//this screen process payment; navigate to result screen (error, complete successully; processing)
class TutorPaymentProccessingScreen extends StatefulWidget {
  final TutorTransaction tutorTransaction;
  final Course course;

  const TutorPaymentProccessingScreen(
      {Key key, @required this.tutorTransaction, @required this.course})
      : super(key: key);

  @override
  _TutorPaymentProccessingScreenState createState() =>
      _TutorPaymentProccessingScreenState();
}

class _TutorPaymentProccessingScreenState
    extends State<TutorPaymentProccessingScreen> {
  final tuteeTransactionRepository = TransactionRepository();
  final courseRepository = CourseRepository();

  // enrollmentRepository.postEnrollment(enrollment);

  Future<bool> completeTutorPayment(
      TutorTransaction tuteeTransaction, Course course) async {
    //post course
    await tuteeTransactionRepository
        .postTutorTransaction(widget.tutorTransaction);
    //post course
    await courseRepository.postCourse(course);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completeTutorPayment(widget.tutorTransaction, widget.course),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
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
