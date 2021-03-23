import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_payment/tutee_payment_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutor_detail/tutor_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';
import './course_detail_screen.dart';

class TuteeHomeCourseDetailScreen extends StatefulWidget {
  final int courseId;

  const TuteeHomeCourseDetailScreen({Key key, @required this.courseId})
      : super(key: key);
  @override
  _TuteeHomeCourseDetailScreenState createState() =>
      _TuteeHomeCourseDetailScreenState();
}

class _TuteeHomeCourseDetailScreenState
    extends State<TuteeHomeCourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(CourseRepository()),
      child: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          //
          final courseCubit = context.watch<CourseCubit>();
          courseCubit.getCoursesByCourseIdTuteeId(
              widget.courseId, authorizedTutee.id);
          //
          // return Container(
          //   height: 100,
          //   color: Colors.red,
          // );
          //render proper ui
          if (state is CourseLoadingState) {
            return buildLoadingIndicator();
          } else if (state is CourseLoadFailedState) {
            return ErrorScreen();
          } else if (state is CourseLoadedState) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildCourseDetailAppbar(context),
              body: buildCourseDetailBody(context, state.course),
              floatingActionButton: buildFollowButton(state.course),
            );
          }
        },
      ),
    );
  }

  //course detail body
  Container buildCourseDetailBody(BuildContext context, ExtendedCourse course) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          //course name title
          Container(
            alignment: Alignment.center,
            height: 60,
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: Text(
              course.name,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: textGreyColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //
          buildDivider(),
          //tutor sumary and initro
          Container(
            height: 120,
            width: 324,
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TutorDetails(
                      tutorId: course.createdBy,
                      courseId: course.id,
                    ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //tutee avatar
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      //avatar background color
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent.withOpacity(.4),
                          shape: BoxShape.circle,
                        ),
                      ),
                      //avatar image
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          course.tutorAvatarUrl,
                        ),
                      ),
                      //
                    ],
                  ),
                  //
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //tutee name
                        Text(
                          course.tutorName,
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                  //arrow
                  Container(
                    padding: EdgeInsets.only(left: 50),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: textGreyColor,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          buildDivider(),
          //course name
          buildCourseInformationListTile(
              course.subjectName, 'Subject', Icons.subject),
          buildDivider(),
          //course name
          buildCourseInformationListTile(
              course.className, 'Class', Icons.grade),
          buildDivider(),
          //school
          buildCourseInformationListTile(
              course.studyForm, 'Study Form', Icons.school),
          buildDivider(),
          //study time
          buildCourseInformationListTile(
              course.beginTime + ' - ' + course.endTime,
              'Study Time',
              Icons.access_time),
          buildDivider(),
          //study week days
          buildCourseInformationListTile(
            course.daysInWeek.replaceFirst('[', '').replaceFirst(']', ''),
            'Days In Week',
            Icons.calendar_today,
          ),
          buildDivider(),
          //begin and end date
          buildCourseInformationListTile(
            course.beginDate + ' to ' + course.endDate,
            'Begin - End Date',
            Icons.date_range,
          ),
          buildDivider(),
          //price of the course
          buildCourseInformationListTile(
            '\$' + course.studyFee.toString(),
            'Study Fee',
            Icons.monetization_on,
          ),
          buildDivider(),
          //maximun tutee in the course
          buildCourseInformationListTile(
            course.maxTutee.toString(),
            'Maximum tutee',
            Icons.person,
          ),
          buildDivider(),
          //description for this course
          buildCourseInformationListTile(
            course.description != '' ? course.description : 'No description',
            'Extra Information',
            Icons.description,
          ),
          //this widget for being nice only
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  FloatingActionButton buildFollowButton(Course course) =>
      FloatingActionButton.extended(
        onPressed: () {
          //navigate to Payment Screen
          //payment screeen wil process properly
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TuteePaymentScreen(course: course),
            ),
          );
        },
        label: Text(
          'Follow',
          style: TextStyle(
            fontSize: titleFontSize,
            color: textWhiteColor,
          ),
        ),
        isExtended: true,
        backgroundColor: mainColor,
      );
}
