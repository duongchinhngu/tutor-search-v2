import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/common_snackbars.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';

class TutorCourseDetailScreen extends StatefulWidget {
  final int courseId;

  const TutorCourseDetailScreen({Key key, @required this.courseId})
      : super(key: key);
  @override
  _TutorCourseDetailScreenState createState() =>
      _TutorCourseDetailScreenState();
}

class _TutorCourseDetailScreenState extends State<TutorCourseDetailScreen> {
  //check whether or not show the course's tutee widget
  bool _checkShowNumberOfTuteeWidget(String status) {
    if (status == CourseConstants.ACTIVE_STATUS) {
      return true;
    } else if (status == CourseConstants.INACTIVE_STATUS) {
      return true;
    } else if (status == CourseConstants.ONGOING_STATUS) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppbar(context),
      body: BlocProvider(
        create: (context) => CourseCubit(
          CourseRepository(),
        ),
        child: BlocBuilder<CourseCubit, CourseState>(builder: (context, state) {
          //
          final courseCubit = context.watch<CourseCubit>();
          courseCubit.getCoursesByCourseId(widget.courseId);
          //
          if (state is CourseLoadingState) {
            return buildLoadingIndicator();
          } else if (state is CourseLoadFailedState) {
            return ErrorScreen();
          } else if (state is CourseLoadedState) {
            return buildCourseDetailBody(context, state.course);
          }
        }),
      ),
    );
  }

  //course detail body
  Container buildCourseDetailBody(BuildContext context, Course course) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
              left: 135,
              right: 135,
              bottom: 20,
              top: 10,
            ),
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mapStatusToColor(course.status),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              course.status,
              style: TextStyle(
                fontSize: titleFontSize,
                color: textWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //
          buildDivider(),
          // //tutees in course
          Visibility(
            visible: _checkShowNumberOfTuteeWidget(course.status),
            child: Column(
              children: [
                Container(
                  height: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //image tutees in course
                      Image.asset(
                        'assets/images/cute-boy-study-with-laptop-cartoon-icon-illustration-education-technology-icon-concept-isolated-flat-cartoon-style_138676-2107.jpg',
                        height: 119,
                      ),
                      //
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Course\'s tutee(s)',
                              style: textStyle,
                            ),
                            //number of tutee in the class
                            Text(
                              '2 tutee(s)',
                              style: titleStyle,
                            )
                          ],
                        ),
                      ),
                      //arrow
                      Icon(
                        Icons.arrow_forward_ios,
                        color: textGreyColor,
                        size: 20,
                      )
                    ],
                  ),
                ),
                //
                buildDivider(),
              ],
            ),
          ),
          //course name
          buildCourseInformationListTile(
              course.classHasSubjectId.toString(), 'Subject', Icons.subject),
          buildDivider(),
          //course name
          buildCourseInformationListTile(course.name, 'Class', Icons.grade),
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
          //description for this course
          buildCourseInformationListTile(
            course.description,
            'Extra Information',
            Icons.description,
          ),
          buildDivider(),
          //active/inactive switch
          Visibility(
            visible: course.status == CourseConstants.ACTIVE_STATUS,
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: ListTile(
                leading: Text(
                  'Deactive course:',
                  style: titleStyle,
                ),
                title: FlutterSwitch(
                  width: 105.0,
                  height: 40.0,
                  activeColor: activeColor,
                  activeText: course.status,
                  activeIcon: Icon(
                    Icons.check,
                    color: activeColor,
                  ),
                  showOnOff: true,
                  value: course.status == CourseConstants.ACTIVE_STATUS,
                  onToggle: (val) {
                    //show confirm dialog
                    showDefaultConfirmDialog(
                        context,
                        'Your course would be inactive forever!',
                        'Are you sure to continue?', () {
                      //change course status
                      course.status = CourseConstants.INACTIVE_STATUS;
                      //navigate to  my tutor course screen
                      Navigator.pop(context);
                      Navigator.pop(context);
                      //deactive courese function
                      CourseRepository()
                          .putCourse(course)
                          .onError((error, stackTrace) {
                        //show done message after done update course
                        ScaffoldMessenger.of(context).showSnackBar(
                          buildDefaultSnackBar(
                            Icons.error_outline_rounded,
                            'Deactive Course Error!',
                            'Please try again.',
                            Colors.red,
                          ),
                        );
                      });
                      //show done message after done update course
                      ScaffoldMessenger.of(context).showSnackBar(
                        buildDefaultSnackBar(
                          Icons.check_circle_outline_outlined,
                          'Deactive Course Successfully!',
                          'Your course status is Inactive now.',
                          Colors.green,
                        ),
                      );
                    });
                  },
                ),
              ),
            ),
          ),
          //
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

//appbar with background image
  PreferredSize _buildAppbar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/top-instructional-design-theories-models-next-elearning-course.jpg',
                  // fit: BoxFit.fitWidth,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          )),
    );
  }
}
