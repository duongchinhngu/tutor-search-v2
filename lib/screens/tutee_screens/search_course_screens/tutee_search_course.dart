import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/cubits/subject_cubit.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/repositories/subject_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/home_screens/tutee_home_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/filter_items/course_filter_popup.dart';
import 'package:tutor_search_system/states/course_state.dart';
import 'package:tutor_search_system/states/subject_state.dart';

class TuteeSearchCourseScreen extends StatefulWidget {
  @override
  _TuteeSearchCourseScreenState createState() =>
      _TuteeSearchCourseScreenState();
}

class _TuteeSearchCourseScreenState extends State<TuteeSearchCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        // height: 220,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 20, right: 120, top: 30),
              child: Text(
                'Hey! What would you like to learn today?',
                style: GoogleFonts.kaushanScript(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Search boxxxx
            SearchBox(),
            //
            ClassHorizontalList(),
          ],
        ),
      ),
    );
  }
}

//SEARCH BOX
class SearchBox extends StatelessWidget {
  SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 35,
            width: 350,
            margin: EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
            ),
            padding: EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              textAlign: TextAlign.start,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 13),
                icon: Icon(
                  Icons.search,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'course, tutor, etc',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: textFontSize,
                ),
              ),
            ),
          ),
          //filter logo
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CourseFilterPopup(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(
                top: 5,
                right: 25,
              ),
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/ic_filter-horizontal-512.png',
                height: 23,
                width: 23,
                color: textGreyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassHorizontalList extends StatefulWidget {
  @override
  _ClassHorizontalListState createState() => _ClassHorizontalListState();
}

class _ClassHorizontalListState extends State<ClassHorizontalList> {
  //seslected index for subject
  int _selectedIndex;
  int _currentSubjectId;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _currentSubjectId = 2;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectCubit(SubjectRepository()),
      child:
          // ignore: missing_return
          BlocBuilder<SubjectCubit, SubjectState>(builder: (context, state) {
        //call subject cubit and get all subjects
        final subjectCubit = context.watch<SubjectCubit>();
        subjectCubit.getAllSubjects();
        //render proper UI for each Subjects state
        if (state is SubjectLoadingState) {
          return buildLoadingIndicator();
        } else if (state is SubjectListLoadedState) {
          //load all subjects and then load courses by subjects id
          return Expanded(
            child: Container(
              color: backgroundColor,
              child: Column(
                children: <Widget>[
                  //list all available subjects
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) {
                        return buildSubjectsHorizontal(
                            index, state.subjects[index]);
                      },
                    ),
                  ),
                  // //show course gridview by subject id
                  CourseGridView(
                    subjectId: _currentSubjectId,
                  ),
                ],
              ),
            ),
          );
        } else if (state is SubjectLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }

  GestureDetector buildSubjectsHorizontal(int index, Subject subject) {
    return GestureDetector(
        onTap: () {
          setState(() {
            // set selected class UI
            _selectedIndex = index;
            //setstate current selected id
            _currentSubjectId = subject.id;
          });
        },
        child: Container(
          width: 110,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                subject.name,
                style: TextStyle(
                  color: _selectedIndex == index ? mainColor : textGreyColor,
                  fontSize: titleFontSize,
                ),
              ),
              Divider(
                indent: 15,
                endIndent: 15,
                color: _selectedIndex == index ? mainColor : Colors.transparent,
                thickness: 1,
              ),
            ],
          ),
        ));
  }
}

class CourseGridView extends StatefulWidget {
  final int subjectId;

  const CourseGridView({Key key, @required this.subjectId}) : super(key: key);
  @override
  _CourseGridViewState createState() => _CourseGridViewState();
}

class _CourseGridViewState extends State<CourseGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(CourseRepository()),
      child: BlocBuilder<CourseCubit, CourseState>(
        // ignore: missing_return
        builder: (context, state) {
          //
          final courseCubit = context.watch<CourseCubit>();
          courseCubit.getCoursesByFilter('Active', widget.subjectId);
          //
          //render proper UI for each Subjects state
          if (state is CourseLoadingState) {
            return buildLoadingIndicator();
          } else if (state is CourseLoadFailedState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else if (state is CourseListLoadedState) {
            return Expanded(
              child: GridView.builder(
                itemCount: state.courses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 4,
                ),
                itemBuilder: (context, index) {
                  return VerticalCourseCard(
                    course: state.courses[index],
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
