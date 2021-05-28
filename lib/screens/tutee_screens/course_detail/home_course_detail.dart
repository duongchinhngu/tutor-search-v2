import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_map/tutee_search_map.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_payment/tutee_payment_processing.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_payment/tutee_payment_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutor_detail/tutor_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/tutor_course_detail_screens/tutor_course_detail_screen.dart';
import 'package:tutor_search_system/states/course_state.dart';
import './course_detail_screen.dart';

String _currentAddress = '';

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
  Position _currentPosition;

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
      });
      await _getAddress();
      // await _genCurrentAddress();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      print('latitude: ' + _currentPosition.latitude.toString());
      print('longitude: ' + _currentPosition.longitude.toString());

      Placemark place = p[0];
      print('1 ${place.name}');
      print('2 ${place.administrativeArea}');
      print('3 ${place.country}');
      print('4 ${place.isoCountryCode}');
      print('5 ${place.locality}');
      print('6 ${place.postalCode}');
      print('7 ${place.street}');
      print('8 ${place.subAdministrativeArea}');
      print('9 ${place.subLocality}');
      print('10 ${place.subThoroughfare}');
      print('11 ${place.thoroughfare}');

      setState(() {
        _currentAddress =
            "${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        print('ALO ALO ALO ALO: ' + _currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
    _getCurrentLocation();
  }

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
            return ErrorScreen();
          } else if (state is CourseLoadedState) {
            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildCourseDetailAppbar(context),
              body: buildCourseDetailBody(context, state.course),
              floatingActionButton: buildFollowButton(context, state.course),
            );
          }
        },
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
      ),
    ),
  );
}

//course detail body
Container buildCourseDetailBody(BuildContext context, ExtendedCourse course) {
  List<String> extraImages = [];
  //
  if (course.extraImages != '[]') {
    extraImages = course.extraImages
        .replaceFirst(']', '')
        .replaceFirst('[', '')
        .split(', ');
  }

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
                    course: course,
                    hasFollowButton: true,
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
        buildCourseInformationListTile(course.className, 'Class', Icons.grade),
        buildDivider(),
        //location
        Visibility(
          visible: course.location != course.tutorAddress,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TuteeSearchGoogleMap(
                        tutoraddress: course.location,
                        tuteeaddress: _currentAddress,
                      )));
            },
            child: buildCourseInformationUrl(
                course.location == course.tutorAddress
                    ? 'At Tutor Home'
                    : course.location,
                'Location',
                Icons.location_on_outlined),
          ),
        ),
        Visibility(
          visible: !(course.location != course.tutorAddress),
          child: buildCourseInformationListTile(
              course.location == course.tutorAddress
                  ? 'At Tutor Home'
                  : course.location,
              'Location',
              Icons.location_on_outlined),
        ),
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
          course.studyFee.toString() + ' vnd',
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
        //Available slot(s)
        buildCourseInformationListTile(
          course.availableSlot.toString(),
          'Available slot(s)',
          Icons.person,
        ),

        buildDivider(),
        buildCourseInformationListTile(
          course.precondition,
          'Precondition',
          Icons.description,
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
                                  // Image.network(
                                  //   extraImages[index],
                                  //   fit: BoxFit.cover,
                                  // ),
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
        //this widget for being nice only
        SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}

FloatingActionButton buildFollowButton(
        BuildContext context, ExtendedCourse course) =>
    FloatingActionButton.extended(
      onPressed: () {
        //insert new enrollment for this tutee and this course, tutor
        // (dont show this course on tutee home screen)
        //init enrollment
        final enrollment = Enrollment.modelConstructor(
          0,
          authorizedTutee.id,
          course.id,
          '',
          StatusConstants.PENDING_STATUS,
        );
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     // builder: (context) => CourseFollowProcessingScreen(enrollment: enrollment),
        //     builder: (context) =>
        //         TuteePaymentScreen(course: course, enrollment: enrollment),
        //   ),
        // );
        showDefaultConfirmDialog(context, 'Join this course', 'Are you sure?',
            () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            return Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => TuteePaymentProccessingScreen(
                  enrollment: enrollment,
                ),
              ),
            );
          });
        });
      },
      label: Text(
        'Join',
        style: TextStyle(
          fontSize: titleFontSize,
          color: textWhiteColor,
        ),
      ),
      isExtended: true,
      backgroundColor: mainColor,
    );

FloatingActionButton buildFeedbackButton(
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
        'Feedback',
        style: TextStyle(
          fontSize: titleFontSize,
          color: textWhiteColor,
        ),
      ),
      isExtended: true,
      backgroundColor: mainColor,
    );
