import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/cubits/tutee_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/tutee_repository.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';
import 'package:tutor_search_system/states/tutee_state.dart';

String sortValue = 'Default sort';

class TutorMyCourseScreen extends StatefulWidget {
  @override
  _TutorMyCourseScreenState createState() => _TutorMyCourseScreenState();
}

class _TutorMyCourseScreenState extends State<TutorMyCourseScreen> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }

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
                  buildCourseStatusCard(1, CourseConstants.UNPAID_STATUS),
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
      floatingActionButton: _buildSSortButton(context),
    );
  }

  Widget _buildSSortButton(BuildContext context) {
    return SpeedDial(
      /// both Default sort to 16
      marginEnd: 18,
      marginBottom: 20,
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      /// This is ignored if animatedIcon is non null
      icon: Icons.sort_rounded,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,

      /// If true overlay will render no matter what.
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black.withOpacity(.1),
      overlayOpacity: 0.5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      children: [
        SpeedDialChild(
          child: Icon(Icons.nature),
          backgroundColor: Colors.orange,
          label: 'Default sort',
          labelBackgroundColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            setState(() {
              sortValue = 'Default sort';
            });
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.arrow_downward_sharp),
          backgroundColor: Colors.cyan,
          label: 'Newest',
          labelBackgroundColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            //
            setState(() {
              sortValue = 'Newest';
            });
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.arrow_upward_sharp),
          label: 'Oldest',
          labelBackgroundColor: Colors.white,
          backgroundColor: Colors.cyan,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            //
            setState(() {
              sortValue = 'Oldest';
            });
          },
        ),
      ],
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
            //
            if (sortValue == 'Oldest') {
              //asc
              state.courses
                  .sort((a, b) => a.createdDate.compareTo(b.createdDate));
            } else if (sortValue == 'Newest') {
              state.courses
                  .sort((a, b) => b.createdDate.compareTo(a.createdDate));
            }
            //
            return Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.courses.length.toString() + ' result(s)',
                          style: TextStyle(
                            fontSize: titleFontSize,
                          ),
                        ),
                        //
                        Text(
                          sortValue,
                          style: TextStyle(
                            fontSize: titleFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
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
                                      )),
                            );
                          },
                          child: TutorCourseCard(context, state.courses[index]),
                        );
                      },
                    ),
                  ),
                ],
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
Widget TutorCourseCard(BuildContext context, Course course) {
  //
  double courseCardHeight = 140;
  //
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
          //
          Container(
            height: courseCardHeight,
            width: 335,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: mapStatusToColor(course.status),
                boxShadow: [
                  boxShadowStyle,
                ]),
          ),
          //
          Container(
            height: courseCardHeight,
            width: 324,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: backgroundColor,
            ),
          ),
          //
          Container(
            height: courseCardHeight,
            width: 324,
            padding: EdgeInsets.only(
              left: 25,
              bottom: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //course name
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Text(
                    course.name,
                    style: titleStyle,
                  ),
                ),
                //weekdays
                Text(
                  course.daysInWeek.replaceFirst('[', '').replaceFirst(']', ''),
                  style: textStyle,
                ),
                //begin-end time
                Text(
                  course.beginTime.substring(0, 5) +
                      ' - ' +
                      course.endTime.substring(0, 5),
                  style: textStyle,
                ),
                //begin date and status
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //begin date
                      Text(
                        'begin ',
                        style: TextStyle(
                            fontSize: textFontSize,
                            color: textGreyColor.withOpacity(0.7)),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          course.beginDate,
                          style: textStyle,
                        ),
                      ),
                      //status
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: mapStatusToColor(course.status),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            course.status,
                            style: TextStyle(
                              fontSize: textFontSize,
                              color: mapStatusToColor(course.status),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // tutee in course
          Positioned(
            top: 15,
            right: 20,
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/cute-boy-study-with-laptop-cartoon-icon-illustration-education-technology-icon-concept-isolated-flat-cartoon-style_138676-2107.jpg',
                    height: 70,
                  ),
                ),
                //
                Container(
                  // height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  // width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: backgroundColor,
                    // shape: BoxShape.circle,
                    // border: Border.all(
                    //     width: 2,
                    //     color: mapStatusToColor(course.status).withOpacity(.2)),
                  ),
                  child: BlocProvider(
                    create: (context) => TuteeCubit(TuteeRepository()),
                    child: BlocBuilder<TuteeCubit, TuteeState>(
                      builder: (context, state) {
                        //
                        final tuteeCubit = context.watch<TuteeCubit>();
                        tuteeCubit.getTuteesByCourseId(course.id);
                        //
                        if (state is TuteeLoadingState) {
                          return Text('loading..');
                        } else if (state is TuteeNoDataState) {
                          return Text(
                            '0 tutee(s)',
                            style: textStyle,
                          );
                        } else if (state is TuteeListLoadedState) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.tutees.length.toString() + ' tutee(s)',
                                  style: textStyle,
                                ),
                              ],
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
        ],
      ),
    ),
  );
}
