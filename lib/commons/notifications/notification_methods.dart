import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void registerOnFirebase() {
  _firebaseMessaging.subscribeToTopic('course');
  _firebaseMessaging
      .getToken()
      .then((token) => print('this is token: ' + token));
}

void getMessage(BuildContext context) {
  _firebaseMessaging.configure(
    // onBackgroundMessage: (Map<String, dynamic> message) async {
    //   print('on backgorund: $message');
    // },
    onMessage: (Map<String, dynamic> message) async {
      print('Messsage here: $message');
      String msgBody = message["notification"]["body"];
      String msgTitle = message["notification"]["title"];
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 350,
            width: 350,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.rectangle,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/megaphone-promotion-marketing-promotion-strategy-promotional-products-concept_335657-828.jpg',
                    fit: BoxFit.contain,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  // 'Your course has been accepted!',
                  msgTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: textGreyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  // 'Andrei Louis like your photos! Check it up now!',
                  msgBody,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textGreyColor,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'),
                  ),
                )
              ],
            ),
          ),
        ),
      );
      // showDialog(
      //     context: context,
      //     builder: (context) => Dialog(
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(16)),
      //           backgroundColor: Colors.transparent,
      //           elevation: 0,
      //           child: Container(
      //             height: 300,
      //             width: 300,
      //             decoration: BoxDecoration(
      //                 color: Colors.blue,
      //                 shape: BoxShape.rectangle,
      //                 borderRadius: BorderRadius.all(Radius.circular(12))),
      //             child: Column(
      //               children: <Widget>[
      //                 // Container(
      //                 //   child: Padding(
      //                 //     padding: const EdgeInsets.all(12.0),
      //                 //     child: Image.asset(
      //                 //       msgJobImage,
      //                 //       height: 120,
      //                 //       width: 50,
      //                 //     ),
      //                 //   ),
      //                 //   width: double.infinity,
      //                 //   decoration: BoxDecoration(
      //                 //       color: Colors.white,
      //                 //       shape: BoxShape.rectangle,
      //                 //       borderRadius: BorderRadius.only(
      //                 //           topLeft: Radius.circular(12),
      //                 //           topRight: Radius.circular(12))),
      //                 // ),
      //                 SizedBox(
      //                   height: 24,
      //                 ),
      //                 Text(
      //                   msgTitle,
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 8,
      //                 ),
      //                 Text(
      //                   msgBody,
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 8,
      //                 ),
      //                 RaisedButton(
      //                   onPressed: () {},
      //                   child: Text('Check it now!'),
      //                   color: Colors.white,
      //                   textColor: Colors.black,
      //                 )
      //               ],
      //             ),
      //           ),
      //         ));
    },
    onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    },
  );
}
