import 'dart:math';

import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutor_screens/course_schedule/preview_course_schedule.dart';

class CourseScheduleScreenV2 extends StatefulWidget {
  final int numberOfWeek;

  const CourseScheduleScreenV2({Key key, @required this.numberOfWeek})
      : super(key: key);

  @override
  _CourseScheduleScreenV2State createState() => _CourseScheduleScreenV2State();
}

class _CourseScheduleScreenV2State extends State<CourseScheduleScreenV2>
    with TickerProviderStateMixin {
  int weekIndex = 1;
  int selectedPageIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(
      vsync: this,
      length: widget.numberOfWeek,
      initialIndex: selectedPageIndex,
    );
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

  //floating action button
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
                      //set for progress indicator
                      weekIndex += 1;
                      //set for page view index
                      selectedPageIndex += 1;
                      _tabController.animateTo(selectedPageIndex);
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

  //app bar
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
              //set for preogress indicator
              weekIndex -= 1;
              //set for page view index
              selectedPageIndex -= 1;
              _tabController.animateTo(selectedPageIndex);
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
            //
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Container buildBodyV2() {
    return Container(
        height: 700,
        child: Column(
          children: [
            //
            StepProgressIndicator(
              totalSteps: widget.numberOfWeek,
              currentStep: weekIndex,
              selectedColor: Colors.green,
              unselectedColor: Colors.grey.withOpacity(0.7),
            ),
            //tabbar view container
            Container(
              height: 500,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: List.generate(
                  widget.numberOfWeek,
                  (index) => Center(
                    child: Text('this is page number: ' + index.toString()),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
