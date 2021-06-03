import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/braintree_payment_functions.dart';
import 'package:tutor_search_system/models/braintree.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:tutor_search_system/repositories/braintree_repository.dart';
import 'package:tutor_search_system/repositories/membership_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/common_snackbars.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/create_course_processing_screen.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/global_variables.dart' as globals;

import 'clone_course_processing_screen.dart';

//show payment method: credit card ỏ debit card or Paypal
Future checkOutTutorPayment(
    BuildContext context,
    Course course,
    List<CourseDetail> courseDetails,
    double totalAmount,
    int usedPoint,
    Fee fee) async {
  //get braintree client token and prepare braintree model
  Braintree braintree = await prepareBraintreeCheckOut(totalAmount);
  //doCheckout() method
  await BraintreeRepository().checkOut(braintree).then((result) {
    if (result) {
      //show payment(check out message)
      ScaffoldMessenger.of(context).showSnackBar(
        buildDefaultSnackBar(
          Icons.check_circle_outline_outlined,
          'Payment completed!',
          'Check out successfully.',
          completedColor,
        ),
      );
      //init model and navigate to process screen
      if (globals.authorizedTutor != null) {
        //post TuteeTransaction
        _completeTutorTransaction(
            context, course, courseDetails, totalAmount, usedPoint, fee);
      }
    } else {
      //show alert undeconstruction
      showDialog(
        context: context,
        builder: (context) => buildDefaultDialog(
          context,
          'Under Construction!',
          'PayPal payment will be soon.',
          [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            )
          ],
        ),
      );
    }
  });
  //
}

//
void _completeTutorTransaction(
    BuildContext context,
    Course course,
    List<CourseDetail> courseDetails,
    double totalAmount,
    int usePoint,
    Fee fee) async {
  //get mêmberhsip
  final membership = await MembershipRepository().fetchMembershipByMembershipId(
      http.Client(), globals.authorizedTutor.membershipId);
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
      (totalAmount * membership.pointRate).round(),
      //used points
      usePoint,
      //need to refactor
      globals.authorizedTutor.id,
      //fee price
      fee.price,
      0);
  //
  WidgetsBinding.instance.addPostFrameCallback((_) {
    return Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => TutorPaymentProccessingScreen(
      //       tutorTransaction: tutorTransaction,
      //       course: course,
      //       courseDetails: courseDetails
      //     ),
      //   ),
      MaterialPageRoute(
        builder: (context) => CloneCourseProcessingScreen(
            tutorTransaction: tutorTransaction,
            course: course,
            courseDetail: courseDetails),
      ),
    );
  });
}
