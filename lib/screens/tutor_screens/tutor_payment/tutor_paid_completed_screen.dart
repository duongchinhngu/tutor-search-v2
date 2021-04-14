import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/repositories/feedback_repository.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_wrapper.dart';
import 'package:http/http.dart' as http;

class TutorPaidCompletedScreen extends StatefulWidget {
  final int savePoint;

  const TutorPaidCompletedScreen({Key key,@required this.savePoint}) : super(key: key);
  @override
  _TutorPaidCompletedScreenState createState() =>
      _TutorPaidCompletedScreenState();
}

class _TutorPaidCompletedScreenState extends State<TutorPaidCompletedScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text('You have just added ' +
                          widget.savePoint.toString() +
                          ' point(s) for the transaction'),
                      title: Image.asset(
                          'assets/images/27a319081c1987c70cdf014833880a5a.jpg'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Ok',
                            style: TextStyle(
                                color: mainColor, fontSize: titleFontSize),
                          ),
                        ),
                      ],
                    )),);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            //welcome title
            Container(
              padding: EdgeInsets.only(top: 110, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 30,
                    color: Colors.greenAccent[700],
                  ),
                  Text(
                    'Your Course has just activated!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        color: textGreyColor,
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //illustration image
            Container(
              padding: EdgeInsets.only(
                top: 0,
                bottom: 20,
              ),
              child: Image.asset(
                'assets/images/happy-school-students-sitting-desk-classroom_179970-1290.jpg',
                width: 300,
                height: 300,
              ),
            ),
            //explanation text field
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                'Your course status is Active now!\nTutee can register to your course. Enjoy your teaching!',
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.grey,
                ),
              ),
            ),
            // navigating to My Course button
            InkWell(
              onTap: () async {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  return Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => TutorBottomNavigatorBar(
                            // selectedIndex: 1,
                            )),
                    ModalRoute.withName('/Home'),
                  );
                });
              },
              child: Container(
                width: 263,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.library_books_rounded,
                        size: 30,
                        color: textWhiteColor,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'My Course',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: textWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
