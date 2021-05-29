import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_detail_cubit.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/repositories/course_detail_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/states/course_detail_state.dart';

class ScheduleScreen extends StatefulWidget {
  final int courseId;

  const ScheduleScreen({Key key, @required this.courseId}) : super(key: key);
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => CourseDetailCubit(CourseDetailRepository()),
        child: BlocBuilder<CourseDetailCubit, CourseDetailState>(
          builder: (context, state) {
            //
            final courseDetailCubit = context.watch<CourseDetailCubit>();
            courseDetailCubit.getByCourseId(widget.courseId);
            //
            if (state is CourseDetailLoadingState) {
              return buildLoadingIndicator();
            } else if (state is CourseDetailLoadingState) {
              return ErrorScreen();
            } else if (state is CourseDetailListLoadedState) {
              return Container(
                  child: ListView.builder(
                itemCount: state.listCourseDetail.length,
                itemBuilder: (context, index) => Week(
                  courseDetail: state.listCourseDetail[index],
                ),
              ));
            }
          },
        ),
      ),
    );
  }

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
                          textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center,
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
