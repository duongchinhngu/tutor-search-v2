import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart'
    as converter;
import 'package:time_range_picker/time_range_picker.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/class_cubit.dart';
import 'package:tutor_search_system/models/class_has_subject.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/repositories/class_has_subject_repository.dart';
import 'package:tutor_search_system/repositories/class_repository.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/common_popups.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'tmp_variables.dart' as tmp_variables;
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/course_schedule_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/schedule_v2.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/week_days_ui.dart';
import 'package:tutor_search_system/states/class_state.dart';
import 'create_course_variables.dart';
import 'preview_course_screen.dart';

TextEditingController quantitySessionController = TextEditingController();

//create course UI;
//this is main ui
// ignore: must_be_immutable
class CreateCourseScreen extends StatefulWidget {
  Subject selectedSubject;
  List<CourseDetail> listCourseDetail;
  List<String> listWeek;
  List<CourseDetail> listPlan;
  List<CourseDetail> listOutcome;

  CreateCourseScreen(
      {Key key,
      this.selectedSubject,
      this.listCourseDetail,
      this.listWeek,
      this.listPlan,
      this.listOutcome})
      : super(key: key);
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  @override
  void initState() {
    //
    print(widget.selectedSubject.name);
    print(selectedClassName);
    courseNameController.text = '';
    if (selectedClassName != 'No select') {
      courseNameController.text =
          widget.selectedSubject.name + ' ' + selectedClassName;
    } else {
      courseNameController.text = widget.selectedSubject.name;
    }
    //
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }

  //validator for all input field
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCreateCourseAppBar(context),
      body: Container(
        color: mainColor,
        child: Form(
          key: formkey,
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
                        controller: courseNameController,
                        maxLength: 100,
                        textAlign: TextAlign.start,
                        onChanged: (context) {
                          //set name = value of this textFormfield on change
                          setState(() {
                            course.name = courseNameController.text.trim();
                          });
                        },
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
                        validator: RequiredValidator(
                            errorText: "Course name is required"),
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
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                      ),
                      subtitle: InkWell(
                        onTap: () {
                          classSelector(context, widget.selectedSubject);
                        },
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
                                selectedClassName,
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
                    //subject
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
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[500]),
                        ),
                      ),
                      subtitle: Container(
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
                        alignment: Alignment.center,
                        child: Text(
                          widget.selectedSubject.name,
                          style: TextStyle(
                              fontSize: titleFontSize,
                              color: mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //begin date - end date
              GestureDetector(
                onTap: () async {
                  //date range;
                  //from date range get start date and end date
                  final range =
                      await dateRangeSelector(context, selectedDateRange);
                  //validate dateRange lasts 7days at least
                  //
                  if (range != null) {
                    if (range.duration.inDays < 6) {
                      //
                      showDialog(
                          context: context,
                          builder: (context) => buildDefaultDialog(
                                  context,
                                  "Invalid!",
                                  "Course lasts at least 7 days or more.", [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'),
                                ),
                              ]));
                    } else {
                      selectedDateRange = range;
                      //set end and start date
                      setEndAndBeginDate(selectedDateRange);
                    }
                  }
                },
                child: Container(
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
                      //edit icon
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: mainColor,
                        ),
                      ),
                      //begin date
                      ListTile(
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
                          ),
                        ),
                        subtitle: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
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
                          child: Text(
                            course.beginDate,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: textGreyColor,
                            ),
                          ),
                        ),
                      ),
                      // end date
                      ListTile(
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
                          ),
                        ),
                        subtitle: Container(
                          height: 50,
                          width: 100,
                          alignment: Alignment.center,
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
                          child: Text(
                            course.endDate,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: textGreyColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //begin time - end time
              GestureDetector(
                onTap: () async {
                  // //need to refactor
                  // //select time range
                  final range = await timeRangeSelector(
                      context, selectedTimeRange, 'Study Time');
                  //calculate difference between 2 time picked
                  final currentDatetime = DateTime.now();
                  final startTime = DateTime(currentDatetime.year, 1, 1,
                      range.startTime.hour, range.startTime.minute);
                  //
                  DateTime endTime = DateTime(currentDatetime.year, 1, 1,
                      range.endTime.hour, range.endTime.minute);
                  //
                  if (startTime.isAfter(endTime)) {
                    endTime = DateTime(currentDatetime.year, 1, 2,
                        range.endTime.hour, range.endTime.minute);
                  }
                  //
                  int diffGap = endTime.difference(startTime).inMinutes;
                  //
                  // print('this is 60 and 16: ${60 * 16}');
                  // print('this is start start: ' + startTime.toString());
                  // print('this is end endtime: ' + endTime.toString());
                  // //
                  // print(" gap is " + diffGap.toString());
                  //
                  if (diffGap >= 30 && diffGap <= 16 * 60) {
                    //
                    if (range != null) {
                      selectedTimeRange = range;
                    }
                    // //set tmpCourse begin and end time
                    setBeginAndEndTime(selectedTimeRange);
                  } else {
                    //
                    showDialog(
                        context: context,
                        builder: (context) => buildDefaultDialog(
                                context,
                                "Invalid!",
                                "Course duration must be 30 min to 16 hours a day",
                                [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'),
                                  ),
                                ]));
                  }
                },
                child: Container(
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
                      //icon edit time
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: mainColor,
                        ),
                      ),
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
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
                            alignment: Alignment.center,
                            child: Text(
                              course.beginTime,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
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
                            alignment: Alignment.center,
                            child: Text(
                              course.endTime,
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: textGreyColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  title: Container(
                    padding: EdgeInsets.only(top: 15),
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
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: WeekDaysComponent(),
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
                    controller: courseFeeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                    onChanged: (context) {
                      setState(() {
                        course.studyFee =
                            double.parse(courseFeeController.text);
                      });
                    },
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
                      RangeValidator(
                          min: 1000,
                          max: 100000000,
                          errorText: "must be from 1000 vnd to 100000000 vnd"),
                      RequiredValidator(errorText: "Study Fee is required"),
                    ]),
                  ),
                ),
              ),
              //max tutee in course
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
                      Icons.person,
                      color: mainColor,
                    ),
                  ),
                  title: TextFormField(
                    controller: courseMaxTuteeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                    onChanged: (context) {
                      setState(() {
                        course.maxTutee =
                            int.parse(courseMaxTuteeController.text);
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Maximum tutee',
                      labelStyle: textStyle,
                      fillColor: Color(0xffF9F2F2),
                      filled: true,
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0.0),
                      ),
                      hintText: 'Number of tutee in your course',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: textFontSize,
                      ),
                    ),
                    validator: MultiValidator([
                      RangeValidator(
                          min: 1, max: 30, errorText: 'from 1 to 30'),
                      RequiredValidator(errorText: " is required"),
                    ]),
                  ),
                ),
              ),
              //location
              Container(
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 20, top: 20, bottom: 0),
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
                      Icons.location_on_outlined,
                      color: mainColor,
                    ),
                  ),
                  title: TextFormField(
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    maxLength: 500,
                    maxLines: null,
                    controller: locationController,
                    textAlign: TextAlign.start,
                    onChanged: (context) {
                      setState(() {
                        course.location = locationController.text;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Course Location',
                      labelStyle: textStyle,
                      fillColor: Color(0xffF9F2F2),
                      filled: true,
                      focusedBorder: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0.0),
                      ),
                      hintText: 'Where course take place..',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: textFontSize,
                      ),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "is required"),
                    ]),
                  ),
                ),
              ),
              //course target
              Container(
                // height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 0, top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 0, top: 20, bottom: 0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [boxShadowStyle],
                ),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      //set plan and calculate number of week if begin and end date were seleted
                      if (selectedDateRange != null) {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseScheduleScreenV2(
                              numberOfWeek:
                                  calculateNumberOfWeek(selectedDateRange),
                              subject: widget.selectedSubject,
                            ),
                          ),
                        );
                      } else {
                        //show alert when datetime is null
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content:
                                Text('Please choose begin and end date first!'),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  //
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: mainColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: Container(
                      child: Icon(
                        Icons.track_changes,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  minLeadingWidth: 15,
                  title: Text(
                    'Please create the schedule for this course',
                    style: titleStyle,
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Column(
                          children: List.generate(targets.length, (index) {
                            return ListTile(
                              leading: Icon(
                                Icons.drag_handle,
                                size: 25,
                                color: Colors.red[300],
                              ),
                              title: Text(
                                targets[index],
                              ),
                              trailing: Icon(
                                Icons.more_vert_outlined,
                                size: 25,
                                color: Colors.red[300],
                              ),
                            );
                          }),
                        ),
                        //
                        SizedBox(
                          height: 20,
                        ),
                        //add target button
                        widget.listCourseDetail.length <= 0
                            ? Column(
                                children: [
                                  Container(
                                    height: 140,
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
                                      children: [
                                        ListTile(
                                          title: TextFormField(
                                            controller:
                                                quantitySessionController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.start,
                                            decoration: InputDecoration(
                                              labelText: 'Quantity of session',
                                              labelStyle: textStyle,
                                              fillColor: Color(0xffF9F2F2),
                                              filled: true,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0.0),
                                              ),
                                              hintText:
                                                  'Number of session in your study plan',
                                              hintStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: textFontSize,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            //set plan and calculate number of week if begin and end date were seleted
                                            if (quantitySessionController
                                                        .text !=
                                                    '' &&
                                                int.parse(
                                                        quantitySessionController
                                                            .text) !=
                                                    0) {
                                              listCourseDetail = [];
                                              //
                                              bool isFromConfirmSchedule =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CourseScheduleScreenV2(
                                                    numberOfWeek:
                                                        // calculateNumberOfWeek(
                                                        //     selectedDateRange),
                                                        int.parse(
                                                            quantitySessionController
                                                                .text),
                                                    subject:
                                                        widget.selectedSubject,
                                                    plan: [],
                                                    outcome: [],
                                                    listSchedule:
                                                        listCourseDetail,
                                                  ),
                                                ),
                                              );
                                              //
                                              if (isFromConfirmSchedule) {
                                                setState(() {
                                                  // widget.course =
                                                  //     tmp_variables.course;
                                                  widget.listCourseDetail =
                                                      tmp_variables
                                                          .listSchedule;
                                                  widget.listOutcome =
                                                      tmp_variables.listOutcome;
                                                  widget.listPlan =
                                                      tmp_variables.listPlan;
                                                  widget.listWeek =
                                                      tmp_variables.listweek;
                                                  widget.selectedSubject =
                                                      tmp_variables
                                                          .selectedSubject;
                                                });
                                                for (var i in widget
                                                    .listCourseDetail) {
                                                  print(
                                                      'thhis is l??t schedule');
                                                  i.showAttributes(i);
                                                }
                                              }
                                            } else {
                                              //show alert when datetime is null
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  content: Text(
                                                      'Quantity of session must be greater than 0'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        //
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Ok',
                                                        style: TextStyle(
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 5),
                                            height: 40,
                                            width: 212,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Create Schedule',
                                              style: TextStyle(
                                                fontSize: titleFontSize,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.redAccent),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  ListTile(
                                    title: TextFormField(
                                      controller: quantitySessionController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        labelText: 'Quantity of session',
                                        labelStyle: textStyle,
                                        fillColor: Color(0xffF9F2F2),
                                        filled: true,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.transparent,
                                              width: 0.0),
                                        ),
                                        hintText:
                                            'Number of session in your study plan',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: textFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      print(widget.listCourseDetail.length);
                                      print(
                                          '=============================================');
                                      print(widget.listWeek.length);
                                      print(widget.listPlan.length);
                                      print(widget.listOutcome.length);
                                      //set plan and calculate number of week if begin and end date were seleted
                                      // if (selectedDateRange != null) {
                                      //

                                      List<CourseDetail> tmpListDetail = [];
                                      if (widget.listCourseDetail != null) {
                                        tmpListDetail = widget.listCourseDetail;
                                      }

                                      bool isFromConfirmSchedule =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CourseScheduleScreenV2(
                                                  numberOfWeek:
                                                      // calculateNumberOfWeek(
                                                      //     selectedDateRange),
                                                      int.parse(
                                                          quantitySessionController
                                                              .text),
                                                  subject:
                                                      widget.selectedSubject,
                                                  plan: widget.listPlan,
                                                  outcome: widget.listOutcome,
                                                  listSchedule: tmpListDetail,
                                                )),
                                      );
                                      //
                                      print('this is is confim schedule: ' +
                                          isFromConfirmSchedule.toString());
                                      if (isFromConfirmSchedule) {
                                        setState(() {
                                          // widget.course =
                                          //     tmp_variables.course;
                                          widget.listCourseDetail =
                                              tmp_variables.listSchedule;
                                          widget.listOutcome =
                                              tmp_variables.listOutcome;
                                          widget.listPlan =
                                              tmp_variables.listPlan;
                                          widget.listWeek =
                                              tmp_variables.listweek;
                                          widget.selectedSubject =
                                              tmp_variables.selectedSubject;
                                        });
                                        for (var i in widget.listCourseDetail) {
                                          print('thhis is l??t schedule');
                                          i.showAttributes(i);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 245,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Edit Schedule',
                                        style: TextStyle(
                                          fontSize: titleFontSize,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.redAccent),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                        //
                      ],
                    ),
                  ),
                ),
              ),
              //condition to join this course
              Container(
                // height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 0, top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 0, top: 20, bottom: 0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [boxShadowStyle],
                ),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      //
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseScheduleScreen(
                                    numberOfWeek: 13,
                                  )));
                    },
                    child: Container(
                      // width: 43,
                      // height: 43,
                      child: Icon(
                        Icons.color_lens_outlined,
                        color: mainColor,
                      ),
                    ),
                  ),
                  minLeadingWidth: 15,
                  title: Text(
                    'Precondition to learn this course',
                    style: titleStyle,
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        Column(
                          children:
                              List.generate(preconditions.length, (index) {
                            return ListTile(
                              leading: Icon(
                                Icons.drag_handle,
                                size: 25,
                                color: Colors.red[300],
                              ),
                              title: Text(
                                preconditions[index],
                              ),
                              trailing: PopupMenuButton(
                                child: Icon(
                                  Icons.more_vert_outlined,
                                  size: 25,
                                  color: Colors.red[300],
                                ),
                                itemBuilder: (context) {
                                  return <PopupMenuItem>[
                                    PopupMenuItem(
                                      child: TextButton(
                                        child: Text('Edit'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //
                                          TextEditingController
                                              preconditionController =
                                              TextEditingController(
                                                  text: preconditions[index]);
                                          GlobalKey<FormState> _formKey =
                                              GlobalKey<FormState>();
                                          //
                                          _buildEditPreconoditionDialog(
                                              context,
                                              _formKey,
                                              preconditionController,
                                              index);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: TextButton(
                                        child: Text(
                                          'Remove',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.red.withOpacity(.8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          //
                                          //remove
                                          setState(() {
                                            preconditions.removeAt(index);
                                          });
                                        },
                                      ),
                                    )
                                  ];
                                },
                              ),
                            );
                          }),
                        ),
                        //
                        SizedBox(
                          height: 20,
                        ),
                        //add condition button
                        GestureDetector(
                          onTap: () {
                            TextEditingController preconditionController =
                                TextEditingController();
                            GlobalKey<FormState> _formKey =
                                GlobalKey<FormState>();
                            //
                            _buildAddPreconoditionDialog(
                                context, _formKey, preconditionController);
                          },
                          child: Container(
                            height: 40,
                            width: 180,
                            alignment: Alignment.center,
                            child: Text(
                              'Add condition',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: mainColor,
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: mainColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ),
              //description
              Container(
                height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 20, top: 20, bottom: 0),
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
                    controller: courseDescriptionController,
                    textAlign: TextAlign.start,
                    onChanged: (context) {
                      setState(() {
                        course.description = courseDescriptionController.text;
                      });
                    },
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
              //
              ////description
              Container(
                // height: 200,
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                margin: EdgeInsets.only(left: 0, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [boxShadowStyle],
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   bottomLeft: Radius.circular(10),
                  // ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          'Extra Image(s)',
                          style: TextStyle(
                            color: textGreyColor,
                            fontSize: titleFontSize,
                          ),
                        ),
                      ),
                      Container(
                        width: 260,
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.spaceBetween,
                          runSpacing: 10,
                          spacing: 10,
                          children: List.generate(
                            extraImages.length,
                            (index) {
                              //element is the first image; it is for take photo by camera
                              if (index == 0) {
                                return InkWell(
                                  onTap: () async {
                                    //select Photo from camera
                                    var img = await getImageFromCamera();
                                    if (img != null) {
                                      setState(() {
                                        extraImages.add(img);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 125,
                                    width: 125,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: mainColor.withOpacity(0.7),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50].withOpacity(.4),
                                      border: Border.all(
                                        width: 1.0,
                                        color: mainColor.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                //view photo in fullscreen
                                return Container(
                                  height: 125,
                                  width: 125,
                                  child: PopupMenuButton(
                                    child: Image.file(
                                      extraImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                    itemBuilder: (context) {
                                      return <PopupMenuItem>[
                                        PopupMenuItem(
                                          child: TextButton(
                                            child: Text('Detail'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImage(
                                                    imageWidget: Image.file(
                                                      extraImages[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        PopupMenuItem(
                                          child: TextButton(
                                            child: Text(
                                              'Remove',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color:
                                                    Colors.red.withOpacity(.8),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                extraImages.removeAt(index);
                                              });
                                            },
                                          ),
                                        )
                                      ];
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //certification images
            ],
          ),
        ),
      ),
    );
  }

//app bar
  AppBar buildCreateCourseAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: IconButton(
          icon: Icon(
            Icons.close,
            color: textGreyColor,
            size: 20,
          ),
          onPressed: () {
            //reset empty all fields
            showDialog(
              context: context,
              builder: (context) => buildDefaultDialog(
                context,
                'Your inputs will be lost!',
                'Are you sure to continue?',
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          resetEmptyCreateCourseScreen();
                          //
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
            //
          }),
      actions: [
        TextButton(
          onPressed: () async {
            //
            //check whether or nowt begin/end date and begin/end time cos bi trung khong
            //neu bi trung thi khong cho tao => inavalid
            Course redundantCourse =
                await CourseRepository().checkValidate(course);
            //
            if (formkey.currentState.validate()) {
              formkey.currentState.save();
              //
              if (course.classHasSubjectId == 0 ||
                  course.beginDate == globals.DEFAULT_NO_SELECT ||
                  course.beginTime == globals.DEFAULT_NO_SELECT ||
                  course.endTime == globals.DEFAULT_NO_SELECT ||
                  course.daysInWeek == '[]' ||
                  course.classHasSubjectId == 0) {
                showDialog(
                    context: context,
                    builder: (context) => buildAlertDialog(
                        context, 'There is an empty required field!'));
              } else if (redundantCourse != null) {
                //
                showDialog(
                    context: context,
                    builder: (context) => buildDefaultDialog(
                            context,
                            "Invalid!",
                            "Same study time with course named: " +
                                redundantCourse.name,
                            [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'),
                              ),
                            ]));
                //
              } else if (listCourseDetail.length <= 0) {
                showDialog(
                    context: context,
                    builder: (context) => buildDefaultDialog(
                            context,
                            "Cannot Preview!",
                            "Course must have the schedule and the preconditions for tutee",
                            [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'),
                              ),
                            ]));
              } else {
                //
                course.name = courseNameController.text.trim();
                precondition = '';
                print(preconditions.length);
                for (int i = 0; i < preconditions.length; i++) {
                  if (i == (preconditions.length - 1)) {
                    precondition = precondition + preconditions[i];
                  } else {
                    precondition = precondition + preconditions[i] + '\n';
                  }
                }
                print('test precondition here=============');
                print(precondition);
                //
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PreviewCourseScreen(
                      course: course,
                      className: selectedClassName,
                      subjectName: widget.selectedSubject.name,
                      precondition: precondition,
                      courseDetail: listCourseDetail,
                    ),
                  ),
                );
              }
            }
          },
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
              'Preview',
              style: TextStyle(
                color: mainColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //set end and begin time ui
  void setBeginAndEndTime(TimeRange timeRange) {
    //set start time if not null
    if (timeRange.startTime != null) {
      setState(() {
        //set start time ui
        course.beginTime =
            converter.convertTimeOfDayToString(timeRange.startTime);
        // globals.timeFormatter.format(new DateTime(1990, 1, 1,
        // timeRange.startTime.hour, timeRange.startTime.minute, 0);
      });
    }
    //set end time if not null
    if (timeRange.endTime != null) {
      setState(() {
        //set entime UI
        course.endTime = converter.convertTimeOfDayToString(timeRange.endTime);
      });
    }
  }

  //setstate for tmpcourse end and begin date
  void setEndAndBeginDate(DateTimeRange range) {
    //

    //set tmpCourse.beginDate = start date
    if (range.start != null) {
      setState(() {
        course.beginDate = converter.convertDayTimeToString(range.start);
      });
    }
    //set tmpCourse.endDate = end date
    if (range.end != null) {
      setState(() {
        course.endDate = converter.convertDayTimeToString(range.end);
      });
    }
  }

  //edit precondition dialog
  Future<dynamic> _buildEditPreconoditionDialog(
      BuildContext context,
      GlobalKey<FormState> _formKey,
      TextEditingController preconditionController,
      int index) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: backgroundColor,
            elevation: 1.0,
            insetAnimationCurve: Curves.ease,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: 350,
                  width: 200,
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //title
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'Precondition to join this course',
                          style: titleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      //text field
                      Container(
                        height: 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 20, bottom: 20),
                        margin: EdgeInsets.only(left: 20, top: 20, bottom: 0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          expands: true,
                          maxLength: 500,
                          maxLines: null,
                          controller: preconditionController,
                          textAlign: TextAlign.start,
                          onChanged: (context) {},
                          decoration: InputDecoration(
                            filled: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                            hintText:
                                'What do tutee need to join your course!?',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: textFontSize,
                            ),
                          ),
                          validator:
                              RequiredValidator(errorText: 'is required'),
                        ),
                      ),
                      //actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Cancel
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: textFontSize + 1,
                                )),
                          ),
                          //ok
                          TextButton(
                            onPressed: () {
                              //
                              if (_formKey.currentState.validate()) {
                                //
                                setState(() {
                                  preconditions[index] =
                                      preconditionController.text;
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: textFontSize + 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  //add precondition dialog
  Future<dynamic> _buildAddPreconoditionDialog(
      BuildContext context,
      GlobalKey<FormState> _formKey,
      TextEditingController preconditionController) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
            backgroundColor: backgroundColor,
            elevation: 1.0,
            insetAnimationCurve: Curves.ease,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: 350,
                  width: 200,
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //title
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          'Precondition to join this course',
                          style: titleStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      //text field
                      Container(
                        height: 200,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(right: 20, bottom: 20),
                        margin: EdgeInsets.only(left: 20, top: 20, bottom: 0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          expands: true,
                          maxLength: 500,
                          maxLines: null,
                          controller: preconditionController,
                          textAlign: TextAlign.start,
                          onChanged: (context) {},
                          decoration: InputDecoration(
                            filled: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.transparent, width: 0.0),
                            ),
                            hintText:
                                'What do tutee need to join your course!?',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: textFontSize,
                            ),
                          ),
                          validator:
                              RequiredValidator(errorText: 'is required'),
                        ),
                      ),
                      //actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Cancel
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: textFontSize + 1,
                                )),
                          ),
                          //ok
                          TextButton(
                            onPressed: () {
                              //
                              if (_formKey.currentState.validate()) {
                                //
                                setState(() {
                                  preconditions
                                      .add(preconditionController.text);
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                color: mainColor,
                                fontSize: textFontSize + 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

//load all classes by api
  Future<dynamic> classSelector(BuildContext context, Subject subject) =>
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: BlocProvider(
                create: (context) => ClassCubit(ClassRepository()),
                child: BlocBuilder<ClassCubit, ClassState>(
                  builder: (context, state) {
                    //
                    final classCubit = context.watch<ClassCubit>();
                    classCubit.getClassBySubjectIdStatus(
                        subject.id, globals.StatusConstants.ACTIVE_STATUS);
                    //
                    if (state is ClassLoadingState) {
                      return buildLoadingIndicator();
                    } else if (state is ClassesLoadFailedState) {
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    } else if (state is ClassListLoadedState) {
                      return Container(
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          itemCount: state.classes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Visibility(
                                visible: selectedClassName ==
                                    state.classes[index].name,
                                child: Icon(
                                  Icons.check,
                                  color: mainColor,
                                  size: 15,
                                ),
                              ),
                              title: Text(
                                state.classes[index].name,
                                style: TextStyle(
                                  color: selectedClassName ==
                                          state.classes[index].name
                                      ? mainColor
                                      : textGreyColor,
                                  fontSize: titleFontSize,
                                ),
                              ),
                              onTap: () async {
                                //call api;
                                //load classHasSubjectId by ClassId and SubjectId
                                //then set tmpCourse.classhasSubject = result
                                final classHasSubjectRepository =
                                    ClassHasSubjectRepository();
                                final ClassHasSubject classHasSubject =
                                    await classHasSubjectRepository
                                        .fetchClassHasSubjectBySubjectIdClassId(
                                            http.Client(),
                                            subject.id,
                                            state.classes[index].id);
                                //
                                Navigator.pop(context);
                                setState(() {
                                  //
                                  courseNameController.text =
                                      courseNameController.text.replaceAll(
                                          ' ' + selectedClassName, '');
                                  //
                                  course.classHasSubjectId = classHasSubject.id;
                                  selectedClassName = state.classes[index].name;
                                  //
                                  courseNameController.text =
                                      courseNameController.text +
                                          ' ' +
                                          selectedClassName;
                                  //
                                });
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          });
}
