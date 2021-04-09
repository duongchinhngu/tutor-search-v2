import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/transaction_screens/tutee_transaction_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_profile/update_tutee_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TuteeProfileManagement extends StatefulWidget {
  final IconData snackBarIcon;
  final String snackBarTitle;
  final String snackBarContent;
  final Color snackBarThemeColor;

  const TuteeProfileManagement(
      {Key key,
      this.snackBarIcon,
      this.snackBarTitle,
      this.snackBarContent,
      this.snackBarThemeColor})
      : super(key: key);

  @override
  _TuteeProfileManagementState createState() => _TuteeProfileManagementState();
}

class _TuteeProfileManagementState extends State<TuteeProfileManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return <PopupMenuItem>[
                PopupMenuItem(
                  child: TextButton(
                    child: Text('Call Report Center'),
                    onPressed: () {
                      Navigator.pop(context);
                      launch('tel:0869631008');
                    },
                  ),
                ),
              ];
            },
            child: Icon(
              Icons.flag_rounded,
              color: Colors.amber,
            ),
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 60, 0, 0),
                child: Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(
                            // state.tutor.avatarImageLink,
                            authorizedTutee.avatarImageLink),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(160, 100, 0, 0),
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        width: 200,
                        height: 40,
                        child: Text(
                          authorizedTutee.fullname,
                          style: TextStyle(
                              color: textWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 20,
                      child: Text(
                        authorizedTutee.email,
                        style: TextStyle(
                          color: textWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateTuteeProfile(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 195, 0, 0),
                  child: Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.blue[900]),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 230),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 30),
                      child: Column(
                        children: [
                          buildCourseInformationListTile(
                              authorizedTutee.gender, 'Gender', Icons.gesture),
                          buildDivider(),
                          buildCourseInformationListTile(authorizedTutee.phone,
                              'Phone Number', Icons.phone_android),
                          buildDivider(),
                          buildCourseInformationListTile(
                              authorizedTutee.address,
                              'Address',
                              Icons.home_outlined),
                          buildDivider(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TuteeTransactionScreen()));
                            },
                            child: buildCourseInformationListTile(
                                '69', 'Transaction', Icons.money),
                          ),
                          buildDivider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
