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
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.studyForm,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.school,
                        // color: mainColor,
                      ),
                      title: Text(
                        state.course.studyForm,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
