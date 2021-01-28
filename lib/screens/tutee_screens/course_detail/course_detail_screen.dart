import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
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
          courseCubit.getCoursesByCourseId(widget.courseId);
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
              appBar: AppBar(
                backgroundColor: backgroundColor,
                elevation: 1.5,
                title: Text(
                  'Course Detail',
                  style: GoogleFonts.kaushanScript(
                    textStyle: TextStyle(
                      color: mainColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: textGreyColor,
                    size: 15,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Container(
                color: backgroundColor,
                child: ListView(
                  children: <Widget>[
                    //tutor intro card
                    Card(
                      margin: EdgeInsets.all(10),
                      elevation: 3,
                      child: Container(
                        height: 140,
                        child: Row(
                          children: <Widget>[
                            //tutor avatar
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/e/e8/Chris_Hemsworth_by_Gage_Skidmore_2_%28cropped%29.jpg'),
                                    ),
                                  ),
                                  Container(
                                    child: Text('Five stars here'),
                                  )
                                ],
                              ),
                            ),
                            //tutor name and dexcription column
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Duong Chinh Ngu',
                                      style: titleStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'is an Australian actor. He first rose to prominence in Australia playing Kim Hyde in the Australian television series Home and Away (2004–07) before beginning a film career in Hollywood. Hemsworth is best known for playing Thor in eight Marvel Cinematic Universe films, beginning with Thor (2011) and appearing most recently in Avengers: Endgame (2019), which established him as one of the leading and highest-paid actors in the world.',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //all COurse detail information
                    ListTile(
                      leading: Icon(
                        Icons.library_books,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.name,
                        style: titleStyle,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.studyForm,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.access_time,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.studyTime,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_today,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.daysInWeek,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textGreyColor,
                        ),
                      ),
                      // title: Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Text('Mon'),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Text('Tue'),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Text('Wed'),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Text('Thu'),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //         ),
                      //         child: Text('Fri'),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             border: Border.all(
                      //               width: 1,
                      //               color: textGreyColor,
                      //             )),
                      //         child: Text(
                      //           'Sat',
                      //           style: textStyle,
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle,
                      //             border: Border.all(width: 1)),
                      //         child: Text('Sun'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    //begin and end date
                    ListTile(
                      leading: Icon(
                        Icons.date_range,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.beginDate + ' - ' + state.course.endDate,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 30,
                      endIndent: 30,
                    ),
                    //price of the course
                    ListTile(
                      leading: Icon(
                        Icons.monetization_on,
                        // color: mainColor,
                      ),
                      title: Text(
                        '\$' + state.course.studyFee.toString(),
                        style: TextStyle(
                          fontSize: titleFontSize,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: buildFollowButton(),
            );
          }
        },
      ),
    );
  }

  FloatingActionButton buildFollowButton() => FloatingActionButton.extended(
        onPressed: () {},
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
