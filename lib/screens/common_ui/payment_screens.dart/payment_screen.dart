import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/fee_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/repositories/fee_repository.dart';
import 'package:tutor_search_system/screens/common_ui/payment_screens.dart/payment_processing.dart';
import 'package:tutor_search_system/states/fee_state.dart';

double totalAmount;
bool isEnableFAB = false;

class PaymentScreen extends StatefulWidget {
  final Course course;

  const PaymentScreen({Key key, @required this.course}) : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 15,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment',
          style: TextStyle(
            fontSize: headerFontSize,
            color: textWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: buildPaymentBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (isEnableFAB) {
            // //show lock
            // showDialog(
            //   context: context,
            //   builder: (_) => WillPopScope(
            //     // ignore: missing_return
            //     onWillPop: () {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         new SnackBar(
            //           duration: Duration(
            //             seconds: 7,
            //           ),
            //           backgroundColor: backgroundColor,
            //           behavior: SnackBarBehavior.floating,
            //           content: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(7),
            //                 topRight: Radius.circular(7),
            //               ),
            //               color: backgroundColor,
            //             ),
            //             height: 50,
            //             child: ListTile(
            //               minLeadingWidth: 60,
            //               leading: Icon(
            //                 Icons.settings_backup_restore_outlined,
            //                 color: mainColor,
            //                 size: 35,
            //               ),
            //               title: Text(
            //                 'Don\'t worry! Your submit is still completing..',
            //                 style: titleStyle,
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //       Navigator.of(context).pushReplacement(new MaterialPageRoute(
            //           builder: (BuildContext context) =>
            //               TuteeBottomNavigatorBar()));
            //     },
            //     child: BlocProvider(
            //       create: (context) => TransactionCubit(
            //         TransactionRepository(),
            //         EnrollmentRepository(),
            //       ),
            //       child: AlertDialog(
            //         elevation: 0.0,
            //         backgroundColor: Colors.transparent,
            //         content: Container(
            //           height: double.infinity,
            //           width: double.infinity,
            //           alignment: Alignment.center,
            //           child: BlocBuilder<TransactionCubit, TransactionState>(
            //             // ignore: missing_return
            //             builder: (context, state) {
            //               //
            //               final transactionCubit =
            //                   context.watch<TransactionCubit>();
            //               //init tuteeTransaction
            //               final tuteeTransaction =
            //                   TuteeTransaction.modelConstructor(
            //                       0,
            //                       '1900-01-01',
            //                       widget.course.studyFee,
            //                       totalAmount,
            //                       '',
            //                       'Successfull',
            //                       globals.tuteeId,
            //                       1);
            //               //init enrollment
            //               final enrollment = Enrollment.modelConstructor(
            //                 0,
            //                 globals.tuteeId,
            //                 widget.course.id,
            //                 'Waiting for acception from Tutor of this course',
            //                 'Pending',
            //               );
            //               //
            //               transactionCubit.completeFollowCourse(
            //                   tuteeTransaction, enrollment);
            //               //
            //               if (state is InitialTransactionState) {
            //                 return CircularProgressIndicator(
            //                   backgroundColor: textWhiteColor,
            //                 );
            //               } else if (state is TransactionErrorState) {
            //                 return Center(
            //                   child: Text(state.errorMessage),
            //                 );
            //               } else if (state is TransactionCompletedState) {
            //                 return Container(
            //                   child: Text('Complteted!'),
            //                 );
            //               }
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            //   barrierDismissible: false,
            // );
            //
            //init tuteeTransaction
            final tuteeTransaction = TuteeTransaction.modelConstructor(
                0,
                '1900-01-01',
                widget.course.studyFee,
                totalAmount,
                '',
                'Successfull',
                globals.tuteeId,
                1);
            //init enrollment
            final enrollment = Enrollment.modelConstructor(
              0,
              globals.tuteeId,
              widget.course.id,
              'Waiting for acception from Tutor of this course',
              'Pending',
            );
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => PaymentProccessingScreen(
                    tuteeTransaction: tuteeTransaction,
                    enrollment: enrollment,
                  ),
                ),
              );
            });
          } else {}
        },
        isExtended: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        label: Container(
          margin: EdgeInsetsDirectional.only(
            bottom: 30,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: mainColor,
              boxShadow: [boxShadowStyle]),
          width: 341,
          height: 88,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 140,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff10D624),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$' + widget.course.studyFee.toString(),
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total Amount',
                    style: TextStyle(
                        fontSize: textFontSize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

// method of Payment screen's body
  Container buildPaymentBody() {
    return Container(
      color: const Color(0xffC9CED4).withOpacity(0.35),
      child: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            color: mainColor,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 8,
                  ),
                  child: Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: textWhiteColor,
                    ),
                  ),
                ),
                //payment method
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.35)),
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/MoMo_Logo.png',
                      height: 40,
                    ),
                    title: Text(
                      'MoMo wallet',
                      style: TextStyle(
                        color: textWhiteColor,
                        fontSize: titleFontSize,
                      ),
                    ),
                  ),
                ),
                //transaction details title
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 8,
                    top: 20,
                  ),
                  child: Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: textWhiteColor,
                    ),
                  ),
                ),
                //transaction details content
                TransactionDetailContent(
                  course: widget.course,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransactionDetailContent extends StatefulWidget {
  final Course course;

  const TransactionDetailContent({Key key, @required this.course})
      : super(key: key);
  @override
  _TransactionDetailContentState createState() =>
      _TransactionDetailContentState();
}

class _TransactionDetailContentState extends State<TransactionDetailContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeeCubit(
        FeeRepository(),
      ),
      child: BlocBuilder<FeeCubit, FeeState>(
        builder: (context, state) {
          //
          final feeCubit = context.watch<FeeCubit>();
          feeCubit.getFeeByFeeId(1);
          //
          if (state is FeeLoadedState) {
            totalAmount = widget.course.studyFee + state.fee.price;
            isEnableFAB = true;
          } else {
            totalAmount = widget.course.studyFee;
          }
          return Container(
            width: 341,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [boxShadowStyle]),
            child: Column(
              children: [
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Text(
                      'Fee name',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Text(
                      state is FeeLoadedState ? state.fee.name : 'Loading..',
                      style: textStyle,
                    ),
                  ),
                ),
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Text(
                      'Transfer to tutor',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Text(
                      widget.course.createdBy.toString(),
                      style: textStyle,
                    ),
                  ),
                ),
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Text(
                      'Amount',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Text(
                      '\$' + widget.course.studyFee.toString(),
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 0,
                ),
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Text(
                      'Fee',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Text(
                      state is FeeLoadedState
                          ? '\$' + state.fee.price.toString()
                          : 'Loading..',
                      style: textStyle,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 0,
                ),
                Container(
                  width: 341,
                  height: 60,
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Text(
                      'Total Amount',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    trailing: Text(
                      '\$' + totalAmount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: headerFontSize),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
