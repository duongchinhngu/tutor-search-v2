import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

class NoDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      // height: double.infinity,
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          //illustration image
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Image.asset(
              'assets/images/no_data.jpg',
              height: 200,

            ),
          ),
          //welcome title
          Container(
            child: Text(
              'No Result Match',
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
              'Try a different search.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textFontSize,
                color: Colors.grey,
              ),
            ),
          ),
          // navigating to My Course button
          // InkWell(
          //   onTap: () async {
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       return Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(
          //             builder: (context) => TuteeBottomNavigatorBar()),
          //         ModalRoute.withName('/Home'),
          //       );
          //     });
          //   },
          //   child: Container(
          //     width: 263,
          //     height: 50,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: mainColor,
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Expanded(
          //           flex: 3,
          //           child: Icon(
          //             Icons.home,
          //             size: 30,
          //             color: textWhiteColor,
          //           ),
          //         ),
          //         Expanded(
          //           flex: 7,
          //           child: Container(
          //             padding: EdgeInsets.only(
          //               left: 20,
          //             ),
          //             child: Text(
          //               'Back to Home',
          //               style: TextStyle(
          //                 fontSize: titleFontSize,
          //                 color: textWhiteColor,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
