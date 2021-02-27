//alert dialog when there is an empty required field
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

//common alert dialog
AlertDialog buildAlertDialog(BuildContext context) {
  return AlertDialog(
    title: Container(
      width: double.infinity,
      // height: 70,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/sad.png',
        height: 70,
        width: 170,
      ),
    ),
    content: Container(
      width: double.infinity,
      height: 20,
      alignment: Alignment.center,
      child: Text(
        'There is an empty required field!',
        style: textStyle,
      ),
    ),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: mainColor, // background
          onPrimary: textWhiteColor, // foreground
          elevation: 1.0,
        ),
        child: Center(
          // width: double.infinity

          child: Text('Ok'),
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      )
    ],
  );
}

//common dialog
AlertDialog buildDialog(
    BuildContext context, String title, String content, List<Widget> actions) {
  return AlertDialog(
    backgroundColor: backgroundColor.withOpacity(1),
    elevation: 0.0,
    title: Text(
      title,
      style: TextStyle(
        color: textGreyColor,
      ),
    ),
    content: Text(
      content,
      style: TextStyle(
        color: textGreyColor,
      ),
    ),
    actions: actions,
  );
}
