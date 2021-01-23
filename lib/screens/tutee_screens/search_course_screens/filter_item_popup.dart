import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/course_filter_popup.dart';

class CourseFilterItemPopup extends StatefulWidget {
  final FilterItem filterItem;

  const CourseFilterItemPopup({Key key, @required this.filterItem})
      : super(key: key);
  @override
  _CourseFilterItemPopupState createState() => _CourseFilterItemPopupState();
}

class _CourseFilterItemPopupState extends State<CourseFilterItemPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        title: Text(
          widget.filterItem.title,
          style: titleStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            textColor: textGreyColor,
            onPressed: () {},
            child: Text(
              'Apply',
              style: TextStyle(
                fontSize: textFontSize,
                color: textGreyColor,
              ),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: textGreyColor,
            size: 15,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: widget.filterItem.subItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Visibility(
                visible: widget.filterItem.subItems[index].isChecked,
                              child: Icon(
                  Icons.check,
                  color: mainColor,
                  size: 15,
                ),
              ),
              title: Text(
                widget.filterItem.subItems[index].name,
                style: TextStyle(
                  color: widget.filterItem.subItems[index].isChecked
                      ? mainColor
                      : textGreyColor,
                  fontSize: titleFontSize,
                ),
              ),
              onTap: () {
                setState(() {
                  widget.filterItem.subItems[index].isChecked =
                      !widget.filterItem.subItems[index].isChecked;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
