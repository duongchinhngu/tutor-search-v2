import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_snackbars.dart';

//sending status
bool isSending = false;
//
Future showReportDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: !isSending,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: backgroundColor,
      elevation: 1.0,
      insetAnimationCurve: Curves.ease,
      child: TutorReportDialog(),
    ),
  );
}

class TutorReportDialog extends StatefulWidget {
  @override
  _TutorReportDialogState createState() => _TutorReportDialogState();
}

class _TutorReportDialogState extends State<TutorReportDialog> {
  //text controller for comment
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IgnorePointer(
        ignoring: isSending,
        ignoringSemantics: true,
        child: Container(
          height: 400,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //title and icon label
              _buildReportTitle(),
              //report type
              
              //comment
              Container(
                height: 180,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10, bottom: 0),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  readOnly: isSending,
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLength: 500,
                  maxLines: null,
                  controller: commentController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                    ),
                    counter: Text(''),
                    hintText: 'Tell us your problems..',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: textFontSize,
                    ),
                  ),
                ),
              ),
              //
              InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                    ),
                    padding: EdgeInsets.only(
                      right: 10,
                    ),
                    width: 115,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: backgroundColor,
                      border: Border.all(width: 1, color: mainColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //
                        Icon(
                          Icons.add,
                          color: mainColor,
                        ),
                        //
                        Text(
                          'Add photo',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // send button
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    // // to lock screen
                    setState(() {
                      isSending = !isSending;
                      //
                    });
                    // //init feedback dto
                    // //tutorId here is 1; temporary
                    // final feedback = Feedbacks.constructor(
                    //   //id
                    //   0,
                    //   //comment
                    //   commentController.text,
                    //   //to tutorId
                    //   widget.tutor.id,
                    //   // //create date
                    //   // defaultDatetime,
                    //   //status
                    //   'Pending',
                    //   //tutee id
                    //   authorizedTutee.id,
                    //   //rate
                    //   selectedRating,
                    //   //this is temporary value; back end will process this
                    //   // defaultDatetime,
                    //   //this is temporary value; back end will process this
                    //   // 0,
                    // );
                    // //post feedback
                    // await feedbackRepository
                    //     .postFeedback(feedback)
                    //     .then((value) => {
                    //           //close feedback dialog
                    //           Navigator.pop(context),
                    //           // show complete feeback
                    //           // showFeedbackCompletedDialog(context),
                    //           //
                    //         })
                    //     .catchError((error) => {
                    //           //close feedback dialog
                    //           Navigator.pop(context),
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             buildDefaultSnackBar(
                    //               Icons.error_outline,
                    //               'Sending feedback failed..',
                    //               'Please try again later.',
                    //               Colors.red[900],
                    //             ),
                    //           ),
                    //         });
                    // //update istakefeedback enrollment is true
                  },
                  child: Container(
                    width: 94,
                    height: 38,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                    ),
                    child: Text(
                      isSending ? 'Sending..' : 'Send',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        color: textWhiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container _buildReportTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //feedback icon
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.flag,
            color: Colors.amber,
            size: 40,
          ),
        ),
        //label
        Text(
          'Report!',
          style: TextStyle(
            fontSize: headerFontSize,
            fontWeight: FontWeight.bold,
            color: defaultBlueTextColor,
          ),
        ),
      ],
    ),
  );
}
