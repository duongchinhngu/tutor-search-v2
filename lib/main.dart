import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/payment_screens.dart/follow_completed_screen.dart';
import 'package:tutor_search_system/screens/login_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/tutor_create_course.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.pontanoSansTextTheme(),
      ),
      home: LoginScreen(),
      // home: CreateCourseWelcomeScreen(),
    );
  }
}
