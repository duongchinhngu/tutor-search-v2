import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
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
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateTuteeProfile(),
            ),
          );
        },
        label: Text('Update Profile'),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: mainColor,
                ),
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
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
                padding: const EdgeInsets.fromLTRB(160, 50, 0, 0),
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
              Container(
                margin: const EdgeInsets.only(top: 140),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 30),
                      child: Column(
                        children: [
                          buildCourseInformationListTile(
                              authorizedTutee.gender, 'Gender', Icons.gesture),
                          buildDivider(),
                          buildCourseInformationListTile(
                              authorizedTutee.birthday, 'Birthday', Icons.cake),
                          buildDivider(),
                          buildCourseInformationListTile(authorizedTutee.phone,
                              'Phone Number', Icons.phone_android),
                          buildDivider(),
                          buildCourseInformationListTile(
                              authorizedTutee.address,
                              'Address',
                              Icons.home_outlined),
                          buildDivider(),
                          //transactions
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TuteeTransactionScreen()));
                            },
                            child: ListTile(
                              leading: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                width: 43,
                                height: 43,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.payment_rounded,
                                  color: mainColor,
                                ),
                              ),
                              title: Text(
                                'My Transaction',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color: textGreyColor,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: textGreyColor,
                                size: 18,
                              ),
                            ),
                          ),
                          buildDivider(),
                          SizedBox(
                            height: 40,
                          )
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

  AppBar buildAppBar() {
    return AppBar(
      title: Text('My Profile'),
      backgroundColor: mainColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(
            Icons.power_settings_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            //show
            showLogoutConfirmDialog(context);
          },
        ),
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
    );
  }
}
