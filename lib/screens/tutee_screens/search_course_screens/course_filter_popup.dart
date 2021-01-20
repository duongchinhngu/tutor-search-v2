import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

class CourseFilterPopup extends StatefulWidget {
  @override
  _CourseFilterPopupState createState() => _CourseFilterPopupState();
}

class _CourseFilterPopupState extends State<CourseFilterPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        title: Text(
          'Filters',
          style: titleStyle,
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   FlatButton(
        //     textColor: Colors.red[300],
        //     onPressed: () {},
        //     child: Text(
        //       'Save',
        //       style: TextStyle(
        //         fontSize: 15,
        //       ),
        //     ),
        //     shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        //   ),
        // ],
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: textGreyColor,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('data'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            'See Results',
            style: TextStyle(
              color: backgroundColor,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        elevation: 1,
      ),
    );
  }
}
