import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/extended_models/extended_course.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/clone_screens/final_schedule_screen.dart';
import 'update_course_proccessing_screen.dart';
import 'update_course_variables.dart' as vars;

class PreviewUpdateCourseScreen extends StatefulWidget {
  final Course course;
  final String subjectName;
  final String className;
  final String precondition;
  final List<CourseDetail> courseDetail;
  const PreviewUpdateCourseScreen({
    Key key,
    @required this.course,
    @required this.subjectName,
    @required this.className,
    @required this.precondition,
    @required this.courseDetail,
  }) : super(key: key);

  @override
  _PreviewUpdateCourseScreenState createState() =>
      _PreviewUpdateCourseScreenState();
}

class _PreviewUpdateCourseScreenState extends State<PreviewUpdateCourseScreen> {
  ExtendedCourse extendedCourse;
  @override
  void initState() {
    //
    extendedCourse = ExtendedCourse(
        widget.course.id,
        widget.course.name,
        widget.course.beginTime,
        widget.course.endTime,
        widget.course.studyFee,
        widget.course.daysInWeek,
        widget.course.beginDate,
        widget.course.endDate,
        widget.course.description,
        widget.course.status,
        widget.course.classHasSubjectId,
        widget.course.createdBy,
        widget.course.createdDate,
        widget.course.confirmedDate,
        widget.course.confirmedBy,
        widget.course.maxTutee,
        widget.course.location,
        widget.course.extraImages,
        vars.targets.toString(),
        widget.precondition,
        widget.subjectName,
        widget.className,
        'followDate',
        'enrollmentStatus',
        authorizedTutor.avatarImageLink,
        authorizedTutor.fullname,
        null,
        authorizedTutor.address,
        false,
        widget.course.maxTutee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildCourseDetailAppbar(context),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: mainColor,
          onPressed: () {
            // print('thí is precondition: ' +  widget.precondition);
            // //show policy (how much this system take from tutor by commission rate)
            // print('this is course pre: ' + extendedCourse.precondition);
            // for (var i in widget.courseDetail) {
            //   i.showAttributes(i);
            // }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateCourseProcessingScreen(
                  course: extendedCourse,
                  courseDetail: widget.courseDetail,
                ),
              ),
            );
          },
          label: Text('Publish')),
    );
  }

  Container _buildBody(BuildContext context) {
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
              extendedCourse.name,
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
              onTap: () {},
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
                          extendedCourse.tutorAvatarUrl,
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
                          extendedCourse.tutorName,
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
          buildcourseInformationListTile(
              extendedCourse.subjectName, 'Subject', Icons.subject),
          buildDivider(),
          //course name
          buildcourseInformationListTile(
              extendedCourse.className, 'Class', Icons.grade),
          buildDivider(),
          //location
          Visibility(
            visible: extendedCourse.location != extendedCourse.tutorAddress,
            child: GestureDetector(
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => TuteeSearchGoogleMap(
              //             tutoraddress: course.location,
              //             tuteeaddress: _currentAddress,
              //           )));
              // },
              child: buildcourseInformationListTile(
                  extendedCourse.location == extendedCourse.tutorAddress
                      ? 'At Tutor Home'
                      : extendedCourse.location,
                  'Location',
                  Icons.location_on_outlined),
            ),
          ),
          Visibility(
            visible: !(extendedCourse.location != extendedCourse.tutorAddress),
            child: buildcourseInformationListTile(
                extendedCourse.location == extendedCourse.tutorAddress
                    ? 'At Tutor Home'
                    : extendedCourse.location,
                'Location',
                Icons.location_on_outlined),
          ),
          buildDivider(),
          //study time
          buildcourseInformationListTile(
              extendedCourse.beginTime + ' - ' + extendedCourse.endTime,
              'Study Time',
              Icons.access_time),
          buildDivider(),
          //study week days
          buildcourseInformationListTile(
            extendedCourse.daysInWeek
                .replaceFirst('[', '')
                .replaceFirst(']', ''),
            'Days In Week',
            Icons.calendar_today,
          ),
          buildDivider(),
          //begin and end date
          buildcourseInformationListTile(
            extendedCourse.beginDate + ' to ' + extendedCourse.endDate,
            'Begin - End Date',
            Icons.date_range,
          ),
          buildDivider(),
          //price of the course
          buildcourseInformationListTile(
            extendedCourse.studyFee.toString() + ' vnd',
            'Study Fee',
            Icons.monetization_on,
          ),
          buildDivider(),
          //maximun tutee in the course
          buildcourseInformationListTile(
            extendedCourse.maxTutee.toString(),
            'Maximum tutee',
            Icons.person,
          ),
          buildDivider(),
          //Available slot(s)
          buildcourseInformationListTile(
            extendedCourse.availableSlot.toString(),
            'Available slot(s)',
            Icons.person,
          ),
          buildDivider(),
          buildcourseInformationListTile(
            extendedCourse.precondition,
            'Precondition',
            Icons.color_lens_outlined,
          ),
          //schedule
          buildDivider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FinalScheduleScreen(
                    listCourseDetail: widget.courseDetail,
                  ),
                ),
              );
            },
            child: ListTile(
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
                  Icons.track_changes,
                  color: Colors.red,
                ),
              ),
              title: Text(
                'Schedule',
                style: TextStyle(
                  fontSize: titleFontSize,
                  color: textGreyColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: textGreyColor,
                size: 18,
              ),
            ),
          ),
          buildDivider(),
          //description for this course
          buildcourseInformationListTile(
            extendedCourse.description != ''
                ? extendedCourse.description
                : 'No description',
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
                vars.extraImages.length != 0
                    ? Wrap(
                        runAlignment: WrapAlignment.spaceBetween,
                        runSpacing: 5,
                        spacing: 5,
                        children:
                            List.generate(vars.extraImages.length, (index) {
                          //view photo in fullscreen
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImage(
                                    imageWidget: Image.network(
                                      vars.extraImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 114,
                              width: 114,
                              child: CachedNetworkImage(
                                imageUrl: vars.extraImages[index],
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          );
                        }),
                      )
                    : Text('No extra images')
              ],
            ),
          ),
          //this widget for being nice only
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  ListTile buildcourseInformationListTile(
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
}

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

//appbar with background image
PreferredSize _buildCourseDetailAppbar(BuildContext context) {
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
