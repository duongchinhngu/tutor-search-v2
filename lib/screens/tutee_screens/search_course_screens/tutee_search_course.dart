import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/class_cubit.dart';
import 'package:tutor_search_system/repositories/class_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/course_filter_popup.dart';
import 'package:tutor_search_system/states/class_state.dart';

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
            Container(
              alignment: Alignment.topCenter,
              height: 60,
              child: Row(
                children: <Widget>[
                  SearchBox(),
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
                        top: 15,
                      ),
                      child: Image.asset(
                        'assets/images/ic_filter-horizontal-512.png',
                        height: 23,
                        width: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      alignment: Alignment.bottomRight,
      height: 30,
      width: 300,
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 5,
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
          contentPadding: const EdgeInsets.only(bottom: 15),
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
    );
  }
}

class ClassHorizontalList extends StatefulWidget {
  @override
  _ClassHorizontalListState createState() => _ClassHorizontalListState();
}

class _ClassHorizontalListState extends State<ClassHorizontalList> {
  //seslected index for class
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClassCubit(ClassRepository()),
      child:
          // ignore: missing_return
          BlocBuilder<ClassCubit, ClassState>(builder: (context, state) {
        //call category cubit and get all classes
        final classCubit = context.watch<ClassCubit>();
        classCubit.getAllClasses();
        //render proper UI for each Class state
        if (state is ClassLoadingState) {
          return buildLoadingIndicator();
        } else if (state is ClassesLoadedState) {
          //load all classes and then load courses by class id
          return Expanded(
            child: Container(
              color: backgroundColor,
              child: Column(
                children: <Widget>[
                  //list all available categories
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.classes.length,
                      itemBuilder: (context, index) {
                        return buildGestureDetector(index, state);
                      },
                    ),
                  ),
                  // //show clothes gridview by categories id
                  // ProductGridView(
                  //     categoryId: state.categories[_selectedIndex].id),
                ],
              ),
            ),
          );
        } else if (state is ClassesLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }

  GestureDetector buildGestureDetector(int index, ClassesLoadedState state) {
    return GestureDetector(
                          onTap: () {
                            setState(() {
                              // set selected class UI
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: 110,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  state.classes[index].name,
                                  style: TextStyle(
                                    color: _selectedIndex == index
                                        ? mainColor
                                        : textGreyColor,
                                    fontSize: titleFontSize,
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                  color: _selectedIndex == index
                                      ? mainColor
                                      : Colors.transparent,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          ));
  }
}
