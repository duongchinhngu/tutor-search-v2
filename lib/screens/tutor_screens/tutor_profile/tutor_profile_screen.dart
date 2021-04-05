import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/certification_images/certification_image_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/feeback/feedback_card.dart';
import 'package:tutor_search_system/screens/tutor_screens/feeback/tutor_feedback_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/transaction_screens/tutor_transaction_screen.dart';

class TutorProfileScreen extends StatefulWidget {
  final Tutor tutor;

  const TutorProfileScreen({Key key, @required this.tutor}) : super(key: key);
  @override
  _TutorProfileScreenState createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        actions: [
          //sign out button
          IconButton(
            icon: Icon(
              Icons.power_settings_new_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              //show
              showLogoutConfirmDialog(context);
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            //header with avatar image
            Stack(
              children: [
                //
                Container(
                  height: 90,
                  color: mainColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //
                      SizedBox(
                        width: 170,
                      ),
                      //
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //
                          Text(
                            widget.tutor.fullname,
                            style: TextStyle(
                                color: backgroundColor,
                                fontSize: headerFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.tutor.email,
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: titleFontSize,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //
                Container(
                  height: 120,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(widget.tutor.avatarImageLink),
                    ),
                  ),
                )
              ],
            ),
            //
            buildCourseInformationListTile(
                widget.tutor.gender, 'Gender', Icons.gesture),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
                widget.tutor.birthday, 'Birthday', Icons.cake),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
                widget.tutor.phone, 'Phone', Icons.phone_android),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
              widget.tutor.address,
              'Address',
              Icons.gesture,
            ),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(widget.tutor.educationLevel,
                'Education Level', Icons.cast_for_education_outlined),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
                widget.tutor.school, 'School', Icons.school_outlined),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(widget.tutor.points.toString(),
                'Available Point(s)', Icons.donut_large_sharp),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(widget.tutor.membershipId.toString(),
                'Current Membership', Icons.card_membership_outlined),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
                widget.tutor.createdDate.substring(0, 10),
                'Created Date',
                Icons.calendar_today_outlined),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            buildCourseInformationListTile(
                widget.tutor.confirmedDate.substring(0, 10),
                'Confirmed Date',
                Icons.calendar_today_sharp),
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            //soical id image
            Container(
              height: 250,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Social Id Image',
                    style: TextStyle(
                      color: textGreyColor,
                      fontSize: titleFontSize,
                    ),
                  ),
                  //social id image
                  Container(
                    height: 200,
                    width: 270,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: mainColor.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[50].withOpacity(.4),
                    ),
                    child: Image.network(
                      widget.tutor.socialIdUrl,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),

            Divider(
              endIndent: 30,
              indent: 50,
            ),
            //certification images
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CertificationImageScreen()));
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
                    Icons.photo_library_outlined,
                    color: mainColor,
                  ),
                ),
                title: Text(
                  'Certification Images',
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
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            //transactions
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TutorTransactionScreen()));
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
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            //feedbacks
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TutorFeedbackScreen()));
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
                    Icons.chat,
                    color: mainColor,
                  ),
                ),
                title: Text(
                  'My Feedback',
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
            ////
            Divider(
              endIndent: 30,
              indent: 50,
            ),
            //
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
