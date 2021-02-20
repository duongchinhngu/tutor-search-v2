import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/subject_gird_screen.dart';

class CreateCourseWelcomeScreen extends StatefulWidget {
  @override
  _CreateCourseWelcomeScreenState createState() =>
      _CreateCourseWelcomeScreenState();
}

class _CreateCourseWelcomeScreenState extends State<CreateCourseWelcomeScreen> {
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
                'assets/images/5d42a1955e4c2e8a3dfe09a1_Illus Web Flat biru-04.png',
                height: 210,
              ),
            ),
            //welcome title
            Container(
              child: Text(
                'Celebrating the power of knowledge!',
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
                'Share your knowledge to the world\n Only the right education.',
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
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   return Navigator.of(context).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //         builder: (context) => TuteeBottomNavigatorBar()),
                //     ModalRoute.withName('/Home'),
                //   );
                // });

                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SubjectGridScreen()),
                );
              },
              child: Container(
                width: 263,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffA80C0C),
                ),
                child: Container(
                  child: Text(
                    'CREATE COURSE',
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
    );
  }
}
