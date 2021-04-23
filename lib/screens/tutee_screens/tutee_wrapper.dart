import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/repositories/account_repository.dart';
import 'package:tutor_search_system/screens/common_ui/notification_screens/notification_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/home_screens/tutee_home_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/my_courses/my_course_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/search_course_welcome_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_profile/tutee_profile_screen.dart';

class TuteeBottomNavigatorBar extends StatefulWidget {
  final selectedIndex;

  const TuteeBottomNavigatorBar({Key key, this.selectedIndex})
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
    //
    //reset token
    getFCMToken().then((token){
      AccountRepository().resetFCMToken( authorizedTutee.email ,token);
      print('token has just reseted');
    });
    //
    screens = [
      TuteeHomeScreen(),
      MyCourseScreen(),
      TuteeSearchCourseWelcomeScreen(),
      NotificationScreen(
        receiverEmail: authorizedTutee.email,
      ),
      TuteeProfileManagement(),
    ];
    if (widget.selectedIndex != null) {
      _currentIndex = widget.selectedIndex;
    }
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
