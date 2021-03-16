//complete tutor transaction
import 'package:flutter/material.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'tutor_payment_processing.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;

void completeTutorTransaction(BuildContext context, Course course,
    double totalAmount, int usePoint, Fee fee) async {
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
      0,
      //used points
      usePoint,
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
