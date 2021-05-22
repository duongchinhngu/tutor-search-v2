import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/cubits/tutee_cubit.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/tutee_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/common_snackbars.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/course_tutee_screens/course_tutee_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_payment/tutor_payment_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';
import 'package:tutor_search_system/states/tutee_state.dart';

class TutorCourseDetailScreen extends StatefulWidget {
  final int courseId;

  const TutorCourseDetailScreen({Key key, @required this.courseId})
      : super(key: key);
  @override
  _TutorCourseDetailScreenState createState() =>
      _TutorCourseDetailScreenState();
}

class _TutorCourseDetailScreenState extends State<TutorCourseDetailScreen> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }

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

  //
  int numberOfTutee = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return BlocProvider(
      lazy: false,
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
          print(state.course.createdDate);
          return buildCourseDetailBody(context, state.course);
        }
      }),
    );
  }

  FloatingActionButton buildPayNowButton(
          BuildContext context, ExtendedCourse course) =>
      FloatingActionButton.extended(
        onPressed: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorPaymentScreen(course: course),
            ),
          );
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

  //course detail body
  Widget buildCourseDetailBody(BuildContext context, ExtendedCourse course) {
    List<String> extraImages = [];
    //
    //
    if (course.extraImages != '[]') {
      extraImages = course.extraImages
          .replaceFirst(']', '')
          .replaceFirst('[', '')
          .split(', ');
    }

    //
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildCourseDetailAppbar(context),
      floatingActionButton: Visibility(
          visible:
              course != null && course.status == CourseConstants.UNPAID_STATUS,
          child: buildPayNowButton(context, course)),
      body: Container(
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
              child: GestureDetector(
                onTap: () {
                  //navigate to COurse tutee screen to show tutees in this course
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CourseTuteeScreen(course: course),
                    ),
                  );
                },
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
                                //
                                BlocProvider(
                                  create: (context) =>
                                      TuteeCubit(TuteeRepository()),
                                  child: BlocBuilder<TuteeCubit, TuteeState>(
                                    builder: (context, state) {
                                      //
                                      final tuteeCubit =
                                          context.watch<TuteeCubit>();
                                      tuteeCubit.getTuteesByCourseId(course.id);
                                      //
                                      if (state is TuteeLoadingState) {
                                        return Text('loading..');
                                      } else if (state is TuteeNoDataState) {
                                        return Text(
                                          '0 tutee(s)',
                                          style: titleStyle,
                                        );
                                      } else if (state
                                          is TuteeListLoadedState) {
                                        //
                                        numberOfTutee = state.tutees.length;
                                        //
                                        return Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.tutees.length.toString() +
                                                    ' tutee(s)',
                                                style: titleStyle,
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                //number of tutee in the class
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
            ),
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
            //price of the course
            buildCourseInformationListTile(
              course.maxTutee.toString(),
              'Maximum tutee',
              Icons.person,
            ),
            buildDivider(),
            //available slots
            buildCourseInformationListTile(
              course.availableSlot.toString(),
              'Available Slot(s)',
              Icons.person,
            ),
            buildDivider(),
            buildCourseInformationListTile(
              course.precondition,
              'Precondition',
              Icons.color_lens_outlined,
            ),
            buildDivider(),
            //description for this course
            buildCourseInformationListTile(
              course.description != '' ? course.description : 'No description',
              'Extra Information',
              Icons.description,
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
                  extraImages.length != 0
                      ? Wrap(
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
                                      imageWidget: CachedNetworkImage(
                                        imageUrl: extraImages[index],
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      //   Image.network(
                                      //     extraImages[index],
                                      //     fit: BoxFit.cover,
                                      //   ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 114,
                                width: 114,
                                child: CachedNetworkImage(
                                  imageUrl: extraImages[index],
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                // Image.network(
                                //   extraImages[index],
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            );
                          }),
                        )
                      : Text('No extra images', style: textStyle),
                ],
              ),
            ),
            buildDivider(),
            //created Date
            buildCourseInformationListTile(
              course.createdDate.substring(0, 19).replaceAll('T', ' '),
              'Created Date',
              Icons.calendar_today_rounded,
            ),
            buildDivider(),
            //confirmed Date
            course.confirmedDate != null
                ? buildCourseInformationListTile(
                    course.confirmedDate.substring(0, 19).replaceAll('T', ' '),
                    'Confirmed Date',
                    Icons.calendar_view_day_sharp,
                  )
                : Container(),
            //
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
                      if (numberOfTutee != 0) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Can not deactivate this course!'),
                            content: Text(
                                'Course can not be deactivated in case there is tutee in course.'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok'))
                            ],
                          ),
                        );
                      } else {
                        //show confirm dialog
                        showDefaultConfirmDialog(
                            context,
                            'Your course would be inactive forever!',
                            'Are you sure to continue?', () async {
                          //change course status
                          course.status = CourseConstants.INACTIVE_STATUS;
                          //navigate to  my tutor course screen
                          Navigator.pop(context);
                          // Navigator.pop(context);
                          //deactive courese function
                          var result =
                              await CourseRepository().putCourse(course);
                          if (result) {
                            //show done message after done update course
                            ScaffoldMessenger.of(context).showSnackBar(
                              buildDefaultSnackBar(
                                Icons.check_circle_outline_outlined,
                                'Deactive Course Successfully!',
                                'Your course status is Inactive now.',
                                Colors.green,
                              ),
                            );
                          } else {
                            //show done message after done update course
                            ScaffoldMessenger.of(context).showSnackBar(
                              buildDefaultSnackBar(
                                Icons.error_outline_rounded,
                                'Deactive Course Error!',
                                'Please try again.',
                                Colors.red,
                              ),
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

//appbar with background image
PreferredSize buildCourseDetailAppbar(BuildContext context) {
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
