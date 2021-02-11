import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 25,
            color: textGreyColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Container(
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: mainColor,
                  )),
              child: Text(
                'Publish',
                style: TextStyle(
                  color: mainColor,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.blueAccent,
        child: ListView(
          padding: EdgeInsets.only(
            top: 20,
          ),
          children: [
            //
            Container(
              height: 320,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [boxShadowStyle],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //course name input
                  ListTile(
                    leading: Container(
                      width: 43,
                      height: 43,
                      child: Icon(
                        Icons.library_books,
                        color: mainColor,
                      ),
                    ),
                    title: TextFormField(
                      maxLength: 100,
                      textAlign: TextAlign.start,
                      onChanged: null,
                      decoration: InputDecoration(
                        labelText: 'Course name',
                        labelStyle: textStyle,
                        fillColor: Color(0xffF9F2F2),
                        filled: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 0.0),
                        ),
                        hintText: 'What should we call your couse',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: textFontSize,
                        ),
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Course name is required"),
                      ]),
                    ),
                  ),
                  Divider(
                    height: 1,
                    indent: 30,
                    endIndent: 20,
                  ),
                  //class bottom up
                  ListTile(
                    leading: Container(
                      width: 43,
                      height: 43,
                      child: Icon(
                        Icons.grade,
                        color: mainColor,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'Class',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //subject bottom up
                  ListTile(
                    leading: Container(
                      width: 43,
                      height: 43,
                      child: Icon(
                        Icons.subject,
                        color: mainColor,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'Subject',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //study form
            Container(
              height: 120,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(right: 20, top: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 43,
                  height: 43,
                  child: Icon(
                    Icons.school,
                    color: mainColor,
                  ),
                ),
                title: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    bottom: 5,
                  ),
                  child: Text(
                    'Study form',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ),
                subtitle: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'No select',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            color: textGreyColor,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          size: 20,
                          color: mainColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //begin date - end date
            Container(
              height: 210,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(left: 20, top: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //begin date
                  ListTile(
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.calendar_today,
                      color: mainColor,
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'Begin date',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.only(
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // end date
                  ListTile(
                    minLeadingWidth: 20,
                    leading: Icon(
                      Icons.calendar_today,
                      color: mainColor,
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'End date',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        margin: EdgeInsets.only(
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //begin time - end time
            Container(
              height: 210,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(right: 20, top: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //begin time
                  ListTile(
                    leading: Container(
                      width: 43,
                      height: 43,
                      child: Icon(
                        Icons.access_time,
                        color: mainColor,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'Begin time',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  //end time
                  ListTile(
                    leading: Container(
                      width: 43,
                      height: 43,
                      child: Icon(
                        Icons.access_time,
                        color: mainColor,
                      ),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        bottom: 5,
                      ),
                      child: Text(
                        'End time',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'No select',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //week days selector
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(left: 20, top: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: ListTile(
                minLeadingWidth: 20,
                title: Container(
                  padding: EdgeInsets.only(
                    top: 15
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: mainColor,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          bottom: 5,
                        ),
                        child: Text(
                          'Days in week',
                          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    width: double.infinity,
                    // margin: EdgeInsets.only(
                    //   right: 20,
                    // ),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey,
                    //       blurRadius: 1,
                    //       offset: Offset(1, 1),
                    //     ),
                    //   ],
                    //   color: Colors.white,
                    // ),
                    child: Wrap(
                      
                      runSpacing: 15,
                      spacing: 20,
                      children: [
                        WeekDayButton(),
                        WeekDayButton(),
                        WeekDayButton(),
                        WeekDayButton(),
                        WeekDayButton(),
                        WeekDayButton(),
                        WeekDayButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //study fee
            Container(
              height: 120,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.only(right: 20, top: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 43,
                  height: 43,
                  child: Icon(
                    Icons.monetization_on,
                    color: mainColor,
                  ),
                ),
                title: TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  onChanged: null,
                  decoration: InputDecoration(
                    labelText: 'Study Fee',
                    labelStyle: textStyle,
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                    ),
                    hintText: 'Fee/Tutee',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: textFontSize,
                    ),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Study Fee is required"),
                  ]),
                ),
              ),
            ),
            // Description
            Container(
              height: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
              margin: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: [boxShadowStyle],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: ListTile(
                leading: Container(
                  width: 43,
                  // height: 43,
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: mainColor,
                  ),
                ),
                title: TextFormField(
                  keyboardType: TextInputType.multiline,
                  expands: true,
                  maxLength: 500,
                  maxLines: null,
                  // minLines: 1,
                  textAlign: TextAlign.start,
                  onChanged: null,
                  decoration: InputDecoration(
                    labelText: 'Description (optional)',
                    labelStyle: textStyle,
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                    ),
                    hintText: 'Extra information about this course..',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: textFontSize,
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

class WeekDayButton extends StatelessWidget {
  const WeekDayButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ]),
      child: Text(
        'Mon',
        style: TextStyle(
          fontSize: titleFontSize,
          color: textGreyColor,
        ),
      ),
    );
  }
}
