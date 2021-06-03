import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/transaction_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_payment/tutor_paid_completed_screen.dart';

//tutor payment processing screen
//this screen process payment; navigate to result screen (error, complete successully; processing)
class TutorPaymentProccessingScreen extends StatefulWidget {
  final TutorTransaction tutorTransaction;
  final Course course;
  final List<CourseDetail> courseDetails;

  const TutorPaymentProccessingScreen(
      {Key key,
      @required this.tutorTransaction,
      @required this.course,
      @required this.courseDetails})
      : super(key: key);

  @override
  _TutorPaymentProccessingScreenState createState() =>
      _TutorPaymentProccessingScreenState();
}

class _TutorPaymentProccessingScreenState
    extends State<TutorPaymentProccessingScreen> {
  final transactionRepository = TransactionRepository();
  final courseRepository = CourseRepository();

//
  Future<bool> completeTutorPayment(
      TutorTransaction tuteeTransaction, Course course) async {
    //post tutor transaction
    await transactionRepository.postTutorTransaction(widget.tutorTransaction);

    //get course by Id
    Course _course = await CourseRepository().fetchCourseById(course.id);
    //put course
    //set course status is active after paid money
    _course.status = CourseConstants.ACTIVE_STATUS;
    //
    await courseRepository.putCourse(_course);
    //
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
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => TutorPaidCompletedScreen(
                          savePoint: widget.tutorTransaction.archievedPoints,
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
