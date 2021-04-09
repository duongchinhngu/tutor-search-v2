import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_payment/tutee_payment_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutor_detail/tutor_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen({Key key, @required this.courseId})
      : super(key: key);
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
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
          //render proper ui
          if (state is CourseLoadingState) {
            return buildLoadingIndicator();
          } else if (state is CourseLoadFailedState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is CourseLoadedState) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildCourseDetailAppbar(context),
              body: buildCourseDetailBody(context, state.course),
              floatingActionButton: Visibility(
                child: buildPayNowButton(context, state.course),
                visible: state.course.enrollmentStatus ==
                    EnrollmentConstants.UNPAID_STATUS,
              ),
            );
          }
        },
      ),
    );
  }

  //course detail body
  Container buildCourseDetailBody(BuildContext context, ExtendedCourse course) {
    List<String> extraImages = [];
    //
    extraImages = course.extraImages
        .replaceFirst(']', '')
        .replaceFirst('[', '')
        .split(', ');
    //
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
          //status
          Container(
            margin: EdgeInsets.only(
              left: 110,
              right: 110,
              bottom: 20,
              top: 10,
            ),
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mapStatusToColor(course.enrollmentStatus),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              course.enrollmentStatus,
              style: TextStyle(
                fontSize: titleFontSize,
                color: textWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
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
                      course: course,
                      hasFollowButton: false,
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
                        //five star here
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
          //location
          buildCourseInformationListTile(
              course.location, 'Location', Icons.location_on_outlined),
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
          //description for this course
          buildCourseInformationListTile(
            course.description != '' ? course.description : 'No description',
            'Extra Information',
            Icons.description,
          ),
          buildDivider(),
          //created date of this course
          buildCourseInformationListTile(
            course?.followDate,
            'Follow Date',
            Icons.calendar_today,
          ),
          buildDivider(),
          //extra images
          Container(
            width: double.infinity,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 5, left: 5),
            child: Column(
              children: [
                //
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 40),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Extra Images',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: mainColor,
                    ),
                  ),
                ),
                //
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 5,
                  spacing: 5,
                  children: List.generate(extraImages.length, (index) {
                    //view photo in fullscreen
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImage(
                              imageWidget: Image.network(
                                extraImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 114,
                        width: 114,
                        child: Image.network(
                          extraImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          buildDivider(),
          //course status
          Container(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: ListTile(
              leading: Text(
                'Course status',
                style: titleStyle,
              ),
              trailing: Container(
                height: 35,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: mapStatusToColor(course.status),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  course.status,
                  style: TextStyle(
                    fontSize: textFontSize,
                    color: textWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          //this widget for being nice only
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

FloatingActionButton buildPayNowButton(
        BuildContext context, ExtendedCourse course) =>
    FloatingActionButton.extended(
      onPressed: () {
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TuteePaymentScreen(course: course, enrollment: widg,),
        //   ),
        // );
      },
      label: Text(
        'Pay now',
        style: TextStyle(
          fontSize: titleFontSize,
          color: textWhiteColor,
        ),
      ),
      isExtended: true,
      backgroundColor: mainColor,
    );

//course infortion listtitle
ListTile buildCourseInformationListTile(
    String content, String title, IconData icon) {
  return ListTile(
    leading: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: mainColor,
      ),
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
    ),
    subtitle: Text(
      content,
      style: title == 'Course Name'
          ? titleStyle
          : TextStyle(
              fontSize: titleFontSize,
              color: textGreyColor,
            ),
    ),
  );
}

ListTile buildCourseInformationListTileBlurInfo(
    String content, String title, IconData icon) {
  return ListTile(
      leading: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: mainColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
      ),
      subtitle: Stack(
        children: [
          Text(
            content,
            style: title == 'Course Name'
                ? titleStyle
                : TextStyle(
                    fontSize: titleFontSize,
                    color: textGreyColor,
                  ),
          ),
          Visibility(
            visible: true,
            child: Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaY: 5,
                    sigmaX: 5,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
}

//default divider for this page
Divider buildDivider() {
  return Divider(
    thickness: 1,
    indent: 30,
    endIndent: 30,
  );
}
