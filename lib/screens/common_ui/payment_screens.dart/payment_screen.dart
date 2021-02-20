import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/fee_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'payment_methods.dart' as payment_methods;
import 'package:tutor_search_system/repositories/fee_repository.dart';
import 'package:tutor_search_system/states/fee_state.dart';

//total amount
double totalAmount;
//global fee var
Fee fee;
//this variable for en/disable 'Pay now' button
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
      floatingActionButton: buildTotalPaymentFAB(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //floating action button for payment
  FloatingActionButton buildTotalPaymentFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        //
        if (isEnableFAB) {
          if (globals.authorizedTutee != null) {
            //post TuteeTransaction
            payment_methods.completeTuteeTransaction(
                context, widget.course, totalAmount);
          } else if (globals.authorizedTutor != null) {
            //post Tutor Transaction
            payment_methods.completeTutorTransaction(
                context, widget.course, totalAmount, fee);
          }
        }
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
                  '\$$totalAmount',
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
                //tutee transaction details content
                Visibility(
                  visible: globals.authorizedTutee != null,
                  child: TuteeTransactionDetailContent(
                    course: widget.course,
                  ),
                ),
                //Tutor transaction detail content
                Visibility(
                  visible: globals.authorizedTutor != null,
                  child: TutorTransactionDetailContent(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

//this transaction detail UI for Tutee payment
class TuteeTransactionDetailContent extends StatefulWidget {
  final Course course;

  const TuteeTransactionDetailContent({Key key, @required this.course})
      : super(key: key);
  @override
  _TuteeTransactionDetailContentState createState() =>
      _TuteeTransactionDetailContentState();
}

//transaction detail Ui for Tutor payment
//show Feename; Fee amount; total amount
class _TuteeTransactionDetailContentState
    extends State<TuteeTransactionDetailContent> {
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
            isEnableFAB = false;
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

//this transaction detail UI for Tutee payment
class TutorTransactionDetailContent extends StatefulWidget {
  @override
  _TutorTransactionDetailContentState createState() =>
      _TutorTransactionDetailContentState();
}

class _TutorTransactionDetailContentState
    extends State<TutorTransactionDetailContent> {
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
          feeCubit.getFeeByFeeId(2);
          //
          if (state is FeeLoadedState) {
            //set global fee to call method compleTutorTransaction
            fee = state.fee;
            //
            totalAmount = state.fee.price;
            isEnableFAB = true;
          } else {
            totalAmount = 0;
            isEnableFAB = false;
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
                Divider(
                  color: Colors.grey[350],
                  indent: 20,
                  endIndent: 20,
                  thickness: 1,
                  height: 0,
                ),
                //Fee
                //Extra fee that pay system
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
                //total amount
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
