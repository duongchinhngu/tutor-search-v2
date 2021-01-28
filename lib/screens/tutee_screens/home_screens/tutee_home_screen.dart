import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

import 'package:tutor_search_system/cubits/course_cubit.dart';
import 'package:tutor_search_system/models/course.dart';

import 'package:tutor_search_system/repositories/course_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/states/class_state.dart';
import 'package:tutor_search_system/states/course_state.dart';

// class TuteeHomeScreen extends StatefulWidget {
//   @override
//   _TuteeHomeScreenState createState() => _TuteeHomeScreenState();
// }

// class _TuteeHomeScreenState extends State<TuteeHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("EasyEdu"),
//       ),

//     );
//   }

//   IconData get newMethod => CupertinoIcons.add_circled_solid;
// }

class TuteeHomeScreen extends StatefulWidget {
  @override
  _TuteeHomeScreenState createState() => _TuteeHomeScreenState();
}

class _TuteeHomeScreenState extends State<TuteeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit(CourseRepository()),
      child:
          // ignore: missing_return
          BlocBuilder<CourseCubit, CourseState>(builder: (context, state) {
        //call category cubit and get all course
        final classCubit = context.watch<CourseCubit>();
        classCubit.getAllCourse();
        //render proper UI for each Course state
        if (state is CourseLoadingState) {
          return buildLoadingIndicator();
        } else if (state is CourseListLoadedState) {
          //load all course and then load courses by class id
          return Scaffold(
            appBar: AppBar(
              title: Text("EasyEdu"),
            ),
            body: GridView.builder(
              itemCount: state.courses.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 4,
              ),
              itemBuilder: (context, index) => courseCard(
                state.courses[index],
              ),
            ),
          );
        } else if (state is CourseLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }

  Padding courseCard(Course course) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 7, 8, 6.5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.02),
            //   spreadRadius: 5,
            //   blurRadius: 7,
            //   offset: Offset(0, 3), // changes position of shadow
            // ),
            boxShadowStyle,
          ],
        ),
        width: 60,
        height: 300,
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  width: 200,
                  height: 150,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(13, 15, 13, 60),
                            child: Text(
                              course.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textWhiteColor,
                                fontSize: 13.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Container(
                            width: 95,
                            height: 95,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                                color: Colors.white),
                            child: FlutterLogo(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/starsmall.png'),
                Image.asset('assets/images/starsmall.png'),
                Image.asset('assets/images/starsmall.png'),
                Image.asset('assets/images/starsmall.png'),
                Image.asset('assets/images/starsmall.png'),
              ],
            ),
            Container(
              child: Text(
                "Nguyen Trung Huy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Image.asset('assets/images/studyicon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Image.asset('assets/images/clockicon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Image.asset('assets/images/distanceicon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Image.asset('assets/images/pricetag.png'),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            course.studyForm,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            course.studyTime,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            '200m',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            course.studyFee.toString(),
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
