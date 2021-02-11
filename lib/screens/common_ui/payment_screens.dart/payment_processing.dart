import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/repositories/transaction_repository.dart';
import 'package:tutor_search_system/screens/common_ui/payment_screens.dart/follow_completed_screen.dart';

import '../error_screen.dart';

class PaymentProccessingScreen extends StatefulWidget {
  final TuteeTransaction tuteeTransaction;
  final Enrollment enrollment;

  const PaymentProccessingScreen(
      {Key key, @required this.tuteeTransaction, @required this.enrollment})
      : super(key: key);
  @override
  _PaymentProccessingScreenState createState() =>
      _PaymentProccessingScreenState();
}

class _PaymentProccessingScreenState extends State<PaymentProccessingScreen> {
  final tuteeTransactionRepository = TransactionRepository();
  final enrollmentRepository = EnrollmentRepository();

  // enrollmentRepository.postEnrollment(enrollment);

  Future<bool> completePayment(
      TuteeTransaction tuteeTransaction, Enrollment enrollment) {
    tuteeTransactionRepository.postTuteeTransaction(widget.tuteeTransaction);
    enrollmentRepository.postEnrollment(enrollment);
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
