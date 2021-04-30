import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/login_screen.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void registerOnFirebase() {
  _firebaseMessaging.subscribeToTopic('course');
  _firebaseMessaging
      .getToken()
      .then((token) => print('this is token: ' + token));
}

Future<String> getFCMToken() async {
  return await _firebaseMessaging.getToken();
}

void getMessage(BuildContext context) {
  _firebaseMessaging.configure(
    // onBackgroundMessage: (Map<String, dynamic> message) async {
    //   //
    //   String msgTitle = message["notification"]["title"];
    //   print('thí í on backGroundmeerssage: ' + msgTitle);
    //   //
    //   if (msgTitle == 'Your account has been inactived') {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //       (_) {
    //         return Navigator.of(context).pushReplacement(
    //           MaterialPageRoute(
    //             builder: (context) => LoginScreen(),
    //           ),
    //         );
    //       },
    //     );
    //   }
    // },
    onMessage: (Map<String, dynamic> message) async {
      // print('Messsage here: $message');
      String msgBody = message["notification"]["body"];
      String msgTitle = message["notification"]["title"];
      //
      if (msgTitle != 'Your account has been inactived') {
        //
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 400,
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
                    height: 30,
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
                    height: 12,
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
                    height: 30,
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
      } else {
        //
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        );
        //
        //
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 400,
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
                    height: 30,
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
                    height: 12,
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
                    height: 30,
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
      }

      //
    },
    onResume: (Map<String, dynamic> message) async {
      //
      String msgTitle = message["notification"]["title"];
      print('thí í onResume: ' + msgTitle);
      //
      if (msgTitle == 'Your account has been inactived') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        );
      }
    },
    onLaunch: (Map<String, dynamic> message) async {
      //
      String msgTitle = message["notification"]["title"];
      print('thí í onlaunch: ' + msgTitle);
      //
      if (msgTitle == 'Your account has been inactived') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        );
      }
    },
  );
}
