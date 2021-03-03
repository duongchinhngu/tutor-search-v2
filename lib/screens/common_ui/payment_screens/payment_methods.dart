import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/screens/common_ui/payment_screens/payment_processing.dart';

//complete tutee transaction
void completeTuteeTransaction(
    BuildContext context, Course course, double totalAmount) {
//init tuteeTransaction
  final tuteeTransaction = TuteeTransaction.modelConstructor(
    0,
    '1900-01-01',
    course.studyFee,
    totalAmount,
    '',
    'Successfull',
    globals.authorizedTutee.id,
    1,
  );
  //init enrollment
  final enrollment = Enrollment.modelConstructor(
    0,
    globals.authorizedTutee.id,
    course.id,
    'Waiting for acception from Tutor of this course',
    'Pending',
  );
  //
  WidgetsBinding.instance.addPostFrameCallback((_) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TuteePaymentProccessingScreen(
          tuteeTransaction: tuteeTransaction,
          enrollment: enrollment,
        ),
      ),
    );
  });
}

//complete tutor transaction
void completeTutorTransaction(BuildContext context, Course course,
    double totalAmount, int usePoint, Fee fee) {
  //reset new value to authorizeTutor
  //then update this authorized tutor to DB
  //
  globals.authorizedTutor.points = globals.authorizedTutor.points - usePoint;
//init tutorTransaction
  final tutorTransaction = TutorTransaction.modelConstructor(
      0,
      globals.defaultDatetime,
      fee.price,
      totalAmount,
      '',
      //temporary status
      'Successful',
      //feeId
      fee.id,
      //achievedPoint
      //need to refactor
      0,
      //used points
      //need to refactor
      0,
      //need to refactor
      globals.authorizedTutor.id);
  // 0,
  // '1900-01-01',
  // course.studyFee,
  // totalAmount,
  // '',
  // 'Successfull',
  // globals.tuteeId,
  // 1);
  //
  WidgetsBinding.instance.addPostFrameCallback((_) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TutorPaymentProccessingScreen(
          tutorTransaction: tutorTransaction,
          course: course,
        ),
      ),
    );
  });
}
