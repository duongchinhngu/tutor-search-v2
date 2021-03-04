import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'tutee_payment_processing.dart';

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
