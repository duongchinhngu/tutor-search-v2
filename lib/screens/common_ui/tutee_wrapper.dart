import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/screens/tutee_screens/home_screens/tutee_home_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/my_courses/my_course_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/tutee_search_course.dart';

class TuteeBottomNavigatorBar extends StatefulWidget {
  final int tuteeId;

  const TuteeBottomNavigatorBar({Key key, @required this.tuteeId})
      : super(key: key);
  @override
  _TuteeBottomNavigatorBarState createState() =>
      _TuteeBottomNavigatorBarState();
}

class _TuteeBottomNavigatorBarState extends State<TuteeBottomNavigatorBar> {
  int _currentIndex = 0;
  var screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      TuteeHomeScreen(),
      MyCourseScreen(
        tuteeId: widget.tuteeId,
      ),
      TuteeSearchCourseScreen(),
      TuteeHomeScreen(),
      TuteeHomeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
            },
          );
        },
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.black38,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('Course'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            title: Text('Notification'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
