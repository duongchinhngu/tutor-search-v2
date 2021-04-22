import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';

class TuteeTransactonDetailScreen extends StatefulWidget {
  final TuteeTransaction tuteeTransaction;

  const TuteeTransactonDetailScreen({Key key, @required this.tuteeTransaction})
      : super(key: key);

  @override
  _TuteeTransactonDetailScreenState createState() =>
      _TuteeTransactonDetailScreenState();
}

class _TuteeTransactonDetailScreenState
    extends State<TuteeTransactonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      registerOnFirebase();
      getMessage(context);
      super.initState();
    }

    //
    var defaultBoldStyle = TextStyle(
      fontSize: headerFontSize,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.8),
    );
    //
    var defaultNormalStyle = TextStyle(
        fontSize: titleFontSize, color: Colors.black87.withOpacity(.7));
    //
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      //
      body: Container(
        child: ListView(
          children: [
            //
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Icon(
                    Icons.payments,
                    size: 45,
                    color: Colors.orange,
                  ),
                  //
                  Container(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tuteeTransaction.commissionName,
                          style: TextStyle(
                              fontSize: headerFontSize + 3,
                              color: Color(0xff04046D),
                              fontWeight: FontWeight.bold),
                        ),
                        //status
                        Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: activeColor,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            widget.tuteeTransaction.status,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: textWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //
                  SizedBox()
                ],
              ),
            ),
            //
            //
            SizedBox(
              height: 15,
            ),
            //
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            //transfer to tutor
            buildInfoElement('Transaction Id',
                widget.tuteeTransaction.id.toString(), defaultNormalStyle),
            //
            buildInfoElement(
              'Total Amount',
              '\$' + widget.tuteeTransaction.totalAmount.toString(),
              defaultBoldStyle,
            ),
            //amount
            buildInfoElement(
              'Amount',
              '\$' + widget.tuteeTransaction.amount.toString(),
              defaultNormalStyle,
            ),
            //fee
            buildInfoElement(
                'Study Fee',
                '\$' + widget.tuteeTransaction.studyFee.toString(),
                defaultNormalStyle),
            //transfer to course
            buildInfoElement('To course', widget.tuteeTransaction.courseName,
                defaultNormalStyle),
            //datetime
            buildInfoElement('Datetime', widget.tuteeTransaction.dateTime,
                defaultNormalStyle),
            //
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            //
          ],
        ),
      ),
    );
  }

  Container buildInfoElement(String label, String info, TextStyle infoStyle) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: titleFontSize,
              color: textGreyColor,
            ),
          ),
          Text(
            info,
            style: infoStyle,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: buildDefaultCloseButton(context),
    );
  }
}
