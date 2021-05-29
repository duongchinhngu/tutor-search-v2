import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/tutor_screens/course_schedule/preview_course_schedule.dart';

class CourseScheduleScreen extends StatefulWidget {
  final int numberOfWeek;

  const CourseScheduleScreen({Key key, @required this.numberOfWeek})
      : super(key: key);

  @override
  _CourseScheduleScreenState createState() => _CourseScheduleScreenState();
}

class _CourseScheduleScreenState extends State<CourseScheduleScreen> {
  int weekIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: buildBodyV2(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      focusColor: Colors.transparent,
      focusElevation: 0,
      highlightElevation: 0,
      splashColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      onPressed: () {
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => UpdateTuteeProfile(),
        //   ),
        // );
      },
      label: Container(
        margin: EdgeInsetsDirectional.only(
          bottom: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        width: 341,
        height: 88,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //
            Container(
              width: 140,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
                color: backgroundColor,
              ),
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewCourseSchedule(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: mainColor,
                ),
                label: Text(
                  'Preview',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
            ),
            //
            Container(
              width: 140,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
                color: mainColor,
              ),
              child: FlatButton.icon(
                onPressed: () {
                  if (weekIndex == widget.numberOfWeek) {
                  } else {
                    setState(() {
                      weekIndex += 1;
                    });
                  }
                },
                icon: Icon(
                  Icons.next_plan,
                  color: backgroundColor,
                ),
                label: Text(
                  'Next',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: titleFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Schedule in ' + widget.numberOfWeek.toString() + ' week(s)',
        style: TextStyle(color: textGreyColor),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: textGreyColor,
          ),
          onPressed: () {
            if (weekIndex == 1) {
              Navigator.pop(context);
            }
            setState(() {
              weekIndex -= 1;
            });
          }),
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            size: 22,
            color: textGreyColor,
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
                          //
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
          },
        )
      ],
    );
  }

  Container buildBodyV2() {
    return Container(
        child: StepProgressIndicator(
      totalSteps: widget.numberOfWeek,
      currentStep: weekIndex,
      selectedColor: Colors.green,
      unselectedColor: Colors.grey.withOpacity(0.7),
    ));
  }
}
