import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';

class FinalScheduleScreen extends StatefulWidget {
  final List<CourseDetail> listCourseDetail;

  const FinalScheduleScreen({Key key, @required this.listCourseDetail})
      : super(key: key);
  @override
  _FinalScheduleScreenState createState() => _FinalScheduleScreenState();
}

class _FinalScheduleScreenState extends State<FinalScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: ListView.builder(
          itemCount: widget.listCourseDetail.length,
          itemBuilder: (context, index) => Week(
            courseDetail: widget.listCourseDetail[index],
          ),
        ),
      ),
    );
  }

  //appbar
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
  final CourseDetail courseDetail;

  const Week({Key key, @required this.courseDetail}) : super(key: key);
  @override
  _WeekState createState() => _WeekState();
}

class _WeekState extends State<Week> {
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
        startChild: Text(widget.courseDetail.period),
        endChild: Container(
          padding: EdgeInsets.only(top: 0, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                      child: Text(widget.courseDetail.schedule,
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
                      child: Text(widget.courseDetail.learningOutcome,
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
              _buildDivider()
            ],
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      endIndent: 30,
    );
  }
}
