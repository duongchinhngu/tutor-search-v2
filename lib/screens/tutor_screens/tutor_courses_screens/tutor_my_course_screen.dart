import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';

class TutorMyCourseScreen extends StatefulWidget {
  @override
  _TutorMyCourseScreenState createState() => _TutorMyCourseScreenState();
}

class _TutorMyCourseScreenState extends State<TutorMyCourseScreen> {
  //default selected status
  String _selectedStatus = 'All';
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1.5,
        title: Text(
          'My Courses',
          style: TextStyle(
            color: mainColor,
            fontSize: headerFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              alignment: Alignment.center,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  buildCourseStatusCard(0, 'All'),
                  buildCourseStatusCard(1, CourseConstants.ACTIVE_STATUS),
                  buildCourseStatusCard(2, CourseConstants.ONGOING_STATUS),
                  buildCourseStatusCard(3, CourseConstants.PENDING_STATUS),
                  buildCourseStatusCard(4, CourseConstants.INACTIVE_STATUS),
                  buildCourseStatusCard(5, CourseConstants.DENIED_STATUS),
                ],
              ),
            ),
            CourseListView(
              currentStatus: _selectedStatus,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildCourseStatusCard(int index, String status) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // set selected class UI
          _selectedStatus = status;
        });
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              status,
              style: TextStyle(
                color: _selectedStatus == status ? mainColor : textGreyColor,
                fontSize: titleFontSize,
              ),
            ),
            Visibility(
              visible: _selectedStatus == status,
              child: Divider(
                color: mainColor,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            )
            // Container(
            //   height: 10,
            //   decoration: BoxDecoration(
            //     color: Colors.red,
            //     border: Border(
            //       bottom: BorderSide(color: Colors.lightGreen, width: 3),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class CourseListView extends StatefulWidget {
  final String currentStatus;

  const CourseListView({Key key, @required this.currentStatus})
      : super(key: key);
  @override
  _CourseListViewState createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(CourseRepository()),
      child: BlocBuilder<CourseCubit, CourseState>(
        // ignore: missing_return
        builder: (context, state) {
          //
          final courseCubit = context.watch<CourseCubit>();
          courseCubit.getTutorCoursesByCourseStatus(
              authorizedTutor.id, widget.currentStatus);
          //
          if (state is CourseLoadingState) {
            return buildLoadingIndicator();
          } else if (state is CourseListLoadedState) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.courses.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //navigate to course detail screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => CourseDetailScreen(
                                  courseId: state.courses[index].id,
                                  hasFollowButton: false,
                                )),
                      );
                    },
                    child: CourseCard(context, state.courses[index]),
                  );
                },
              ),
            );
          } else if (state is CourseLoadFailedState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is CourseNoDataState) {
            return NoDataScreen();
          }
        },
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CourseCard(BuildContext context, Course course) {
  return GestureDetector(
    onTap: () {
      //
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TutorCourseDetailScreen(
          courseId: course.id,
        ),
      ));
    },
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        bottom: 20,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Container(
            height: 85,
            width: 335,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: course.status == 'Active'
                    ? activeColor
                    : (course.status == 'Denied')
                        ? deniedColor
                        : pendingColor,
                boxShadow: [
                  boxShadowStyle,
                ]),
          ),
          Container(
            height: 85,
            width: 324,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: backgroundColor,
            ),
          ),
          Container(
            height: 85,
            width: 324,
            padding: EdgeInsets.only(
              left: 15,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    course.name,
                    style: titleStyle,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'state.tutor.avatarImageLink',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsetsDirectional.only(
                              start: 10,
                            ),
                            child: Text(
                              'Tutor ' + course.createdBy.toString(),
                              style: textStyle,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: course.status == 'Active'
                                        ? Colors.green.shade400
                                        : (course.status == 'Denied')
                                            ? Colors.red
                                            : Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  child: Text(
                                    course.status,
                                    style: textStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
