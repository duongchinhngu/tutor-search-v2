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
      body: Container(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                'sneakerhead',
                style: titleStyle,
              ),
              subtitle: Text(
                'jordan 4 royalty',
                style: textStyle,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 10,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: 10,
        ),
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
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 1,
      ),
    );
  }
}
