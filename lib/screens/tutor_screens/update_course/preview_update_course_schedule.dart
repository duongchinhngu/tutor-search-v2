import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/tutor_screens/update_course/update_course_variables.dart'
    as vars;
import 'tmp_variables.dart' as tmp;

List<String> week = [];

class PreviewUpdateCourseSchedule extends StatefulWidget {
  final List<CourseDetail> listSchedule;
  final List<String> listweek;
  final Subject subject;
  final int numOfWeek;
  final List<CourseDetail> listPlan;
  final List<CourseDetail> listOutcome;

  const PreviewUpdateCourseSchedule(
      {Key key,
      this.listSchedule,
      this.listweek,
      @required this.subject,
      this.numOfWeek,
      this.listPlan,
      this.listOutcome})
      : super(key: key);
  @override
  _PreviewUpdateCourseScheduleState createState() =>
      _PreviewUpdateCourseScheduleState();
}

class _PreviewUpdateCourseScheduleState
    extends State<PreviewUpdateCourseSchedule> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
          // width: double.infinity,
          // height: 500,
          child: ListView.builder(
        itemCount: widget.listweek.length,
        itemBuilder: (context, index) => Week(
          week: widget.listweek[index],
          list: widget.listSchedule,
        ),
      )),
      // buildDoneButton(context),
      floatingActionButton: buildDoneButton(context),
    );
  }

  Widget buildDoneButton(BuildContext context) => Visibility(
        visible: true,
        child: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                int check;
                for (int i = 0; i < widget.listweek.length; i++) {
                  check = 0;
                  for (int j = 0; j < widget.listSchedule.length; j++) {
                    if (widget.listSchedule[j].period == widget.listweek[i]) {
                      check = check + 1;
                    }
                  }
                }
                if (widget.listweek.length < widget.numOfWeek) check = 0;
                if (check == 0) {
                  showDialog(
                      context: context,
                      builder: (context) => buildDefaultDialog(
                              context,
                              'Cannot Finish',
                              'All week must be filled the plan!', [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK')),
                          ]));
                } else {
                  tmp.course = vars.course;
                  tmp.listSchedule = widget.listSchedule;
                  tmp.listOutcome = widget.listOutcome;
                  tmp.listPlan = widget.listPlan;
                  //
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                  //
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => UpdateCourseScreen(
                  //             course: vars.course,
                  //             listCourseDetail: widget.listSchedule,
                  //             // selectedSubject: widget.subject,
                  //             listPlan: widget.listPlan,
                  //             listOutcome: widget.listOutcome,
                  //           )),
                  // );
                }
              });
            },
            label: Text(
              'Confirm',
              style: TextStyle(
                  fontSize: titleFontSize,
                  color: mainColor,
                  fontWeight: FontWeight.bold),
            ),
            isExtended: true,
            backgroundColor: Colors.white),
      );

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: mainColor,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            size: 22,
            color: backgroundColor,
          ),
          onPressed: () {
            //
            Navigator.pop(context);
          },
        )
      ],
      title: Text('Course Schedule'),
    );
  }
}

class Week extends StatefulWidget {
  final String week;
  final List<CourseDetail> list;

  const Week({Key key, this.week, this.list}) : super(key: key);
  @override
  _WeekState createState() => _WeekState();
}

class _WeekState extends State<Week> {
  List<CourseDetail> listPlan = [];
  @override
  void initState() {
    for (int i = 0; i < widget.list.length; i++) {
      if (widget.list[i].period == widget.week) {
        listPlan.add(widget.list[i]);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TimelineTile(
        hasIndicator: true,
        lineXY: 0.2,
        indicatorStyle: IndicatorStyle(
          width: 18,
          height: 18,
          indicator: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Color(0xff04B431),
            ),
          ),
          drawGap: true,
        ),
        alignment: TimelineAlign.manual,
        afterLineStyle: LineStyle(
          color: Colors.grey.withOpacity(.7),
          thickness: 1,
        ),
        beforeLineStyle: LineStyle(
          color: Colors.grey.withOpacity(.7),
          thickness: 1,
        ),
        startChild: Text(
          widget.week,
          style: TextStyle(
            fontSize: titleFontSize,
            color: Colors.black.withOpacity(.8),
          ),
        ),
        endChild: Container(
            margin: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                listPlan.length,
                (index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Content',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: Colors.black.withOpacity(.8),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(listPlan[index].schedule,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  color: textGreyColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    //
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Outcome',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                color: Colors.black.withOpacity(.8),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(listPlan[index].learningOutcome,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  color: textGreyColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 30,
                    ),
                  ],
                ),
              ),
            )
            // ListView.builder(
            //   itemCount: listPlan.length,
            //   itemBuilder: (context, index) => Column(
            //     children: [
            //       Container(
            //         child: Row(
            //           children: [Text('Plan: '), Text(listPlan[index].schedule)],
            //         ),
            //       ),
            //       Container(
            //         child: Row(
            //           children: [
            //             Text('Outcome: '),
            //             Text(listPlan[index].learningOutcome),
            //           ],
            //         ),
            //       ),
            //       buildDivider(),
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }
}

class WeekElement extends StatelessWidget {
  final String week;

  const WeekElement({Key key, this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TimelineTile(
        hasIndicator: true,
        lineXY: 0.2,
        indicatorStyle: IndicatorStyle(
          width: 18,
          height: 18,
          indicator: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Color(0xff04B431),
            ),
          ),
          drawGap: true,
        ),
        alignment: TimelineAlign.manual,
        afterLineStyle: LineStyle(
          color: Colors.grey.withOpacity(.7),
          thickness: 1,
        ),
        beforeLineStyle: LineStyle(
          color: Colors.grey.withOpacity(.7),
          thickness: 1,
        ),
        startChild: Text('Week 12'),
        endChild: Container(
          margin: EdgeInsets.only(top: 20, left: 15),
          child: Text('This is line 1.\nThis is line 2.'),
        ),
      ),
    );
  }
}
