import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tutor_search_system/commons/colors.dart';

class PreviewCourseSchedule extends StatefulWidget {
  @override
  _PreviewCourseScheduleState createState() => _PreviewCourseScheduleState();
}

class _PreviewCourseScheduleState extends State<PreviewCourseSchedule> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
          child: ListView(
        children: [
          //
          // TimelineTile(
          //   beforeLineStyle: LineStyle(
          //     color: Colors.green,
          //     thickness: 1,
          //   ),
          //   endChild: Text('this is plan'),
          //   isFirst: true,
          // ),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          WeekElement(),
          // TimelineTile(
          //   beforeLineStyle: LineStyle(
          //     color: Colors.green,
          //     thickness: 1,
          //   ),
          //   endChild: Text('this is plan'),
          //   isLast: true,
          // ),
        ],
      )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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

class WeekElement extends StatelessWidget {
  const WeekElement({
    Key key,
  }) : super(key: key);

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
          child: Text(
              'This is line 1.\nThis is line 2.'),
        ),
      ),
    );
  }
}
