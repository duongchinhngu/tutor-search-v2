import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/subject_grid_screen.dart';

class TuteeSearchCourseWelcomeScreen extends StatefulWidget {
  @override
  _TuteeSearchCourseWelcomeScreenState createState() =>
      _TuteeSearchCourseWelcomeScreenState();
}

class _TuteeSearchCourseWelcomeScreenState
    extends State<TuteeSearchCourseWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: mainColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            //welcome slogan on the toppest
            SearchSloganTitle(),
            //Search boxxxx
            SearchSubjectBox(),
            // //
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10,
                ),
                child: SubjectGridView(),
              ),
            ),
            // SubjectGridScreen(),
          ],
        ),
      ),
    );
  }
}

//slogan
class SearchSloganTitle extends StatelessWidget {
  const SearchSloganTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

// class CourseGridView extends StatefulWidget {
//   final int subjectId;

//   const CourseGridView({Key key, @required this.subjectId}) : super(key: key);
//   @override
//   _CourseGridViewState createState() => _CourseGridViewState();
// }

// class _CourseGridViewState extends State<CourseGridView> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CourseCubit(CourseRepository()),
//       child: BlocBuilder<CourseCubit, CourseState>(
//         // ignore: missing_return
//         builder: (context, state) {
//           //
//           final courseCubit = context.watch<CourseCubit>();
//           courseCubit.getCoursesByFilter('Active', widget.subjectId);
//           //
//           //render proper UI for each Subjects state
//           if (state is CourseLoadingState) {
//             return buildLoadingIndicator();
//           } else if (state is CourseLoadFailedState) {
//             return Center(
//               child: Text(state.errorMessage),
//             );
//           } else if (state is CourseListLoadedState) {
//             return Expanded(
//               child: GridView.builder(
//                 itemCount: state.courses.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 2 / 4,
//                 ),
//                 itemBuilder: (context, index) {
//                   return VerticalCourseCard(
//                     course: state.courses[index],
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
