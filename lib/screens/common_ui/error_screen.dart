import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/tutee_wrapper.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            //illustration image
            Container(
              padding: EdgeInsets.only(top: 110, bottom: 40),
              child: Image.asset(
                'assets/images/jiomoney_somethingwentwrong-01.png',
              ),
            ),
            //welcome title
            Container(
              child: Text(
                'Oops! Somethings went wrong..',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: textGreyColor,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //explanation text field
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 30,
              ),
              child: Text(
                'Keep calm! Check your connection\n and try again.',
                textAlign: TextAlign.center,
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
                        builder: (context) => TuteeBottomNavigatorBar()),
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
                    boxShadow: [boxShadowStyle]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.home,
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
                          'Back to Home',
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
