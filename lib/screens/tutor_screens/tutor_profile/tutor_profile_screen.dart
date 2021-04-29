import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/tutor_cubit.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/membership_screens/membership_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/certification_image_screen/certification_image_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/feeback/tutor_feedback_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/transaction_screens/tutor_transaction_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/update_tutor_profile/update_tutor_profile.dart';
import 'package:tutor_search_system/states/tutor_state.dart';

class TutorProfileScreen extends StatefulWidget {
  final Tutor tutor;

  const TutorProfileScreen({Key key, @required this.tutor}) : super(key: key);
  @override
  _TutorProfileScreenState createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (BuildContext context) => TutorCubit(TutorRepository()),
        child: BlocBuilder<TutorCubit, TutorState>(builder: (context, state) {
          //
          final tutorCubit = context.watch<TutorCubit>();
          tutorCubit.getTutorByTutorId(widget.tutor.id);
          //
          if (state is TutorLoadFailedState) {
            return ErrorScreen();
            // return Text(state.errorMessage);
          } else if (state is TutorLoadingState) {
            return buildLoadingIndicator();
          } else if (state is ExtendedTutorLoadedState) {
            authorizedTutor = state.tutor;
            //
            return Container(
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
                                  state.tutor.fullname,
                                  style: TextStyle(
                                      color: backgroundColor,
                                      fontSize: headerFontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.tutor.email,
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
                                NetworkImage(state.tutor.avatarImageLink),
                          ),
                        ),
                      )
                    ],
                  ),

                  buildCourseInformationListTile(
                      state.tutor.gender, 'Gender', Icons.gesture),
                  buildDivider(),
                  buildCourseInformationListTile(
                      state.tutor.birthday, 'Birthday', Icons.cake),
                  buildDivider(),
                  buildCourseInformationListTile(
                      state.tutor.phone, 'Phone', Icons.phone_android),
                  buildDivider(),
                  buildCourseInformationListTile(
                    state.tutor.address,
                    'Address',
                    Icons.home_outlined,
                  ),
                  buildDivider(),
                  buildCourseInformationListTile(state.tutor.educationLevel,
                      'Education Level', Icons.cast_for_education_outlined),
                  buildDivider(),
                  buildCourseInformationListTile(
                      state.tutor.school, 'School', Icons.school_outlined),
                  buildDivider(),
                  buildCourseInformationListTile(state.tutor.points.toString(),
                      'Available Point(s)', Icons.donut_large_sharp),
                  buildDivider(),

                  //certification images
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MembershipScreen()));
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
                          Icons.card_membership_outlined,
                          color: mainColor,
                        ),
                      ),
                      title: Text(
                        'Current Membership',
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                      subtitle: Text(
                        membershipName,
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
                  buildCourseInformationListTile(state.tutor.createdDate,
                      'Created Date', Icons.calendar_today_outlined),
                  buildDivider(),
                  buildCourseInformationListTile(state.tutor.confirmedDate,
                      'Confirmed Date', Icons.calendar_today_sharp),
                  buildDivider(),
                  buildCourseInformationListTile(
                    state.tutor.description,
                    'Description',
                    Icons.description,
                  ),
                  buildDivider(),
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
                            state.tutor.socialIdUrl,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),

                  buildDivider(),
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
                  buildDivider(),
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
                  buildDivider(),
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
                  buildDivider(),
                  //
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      elevation: 0,
      title: Text('Tutor Profile'),
      actions: [
        //update button
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    UpdateTutorProfileScreen(tutor: authorizedTutor),
              ),
            );
          },
          child: buildEditProfileButton(),
        ),
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
    );
  }

  Container buildEditProfileButton() {
    return Container(
      // height: 0,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: mainColor,
        border: Border.all(width: 1, color: backgroundColor),
      ),
      child: Center(
        child: Text(
          'Edit Profile',
          style: TextStyle(
            color: backgroundColor,
          ),
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      endIndent: 30,
      indent: 50,
    );
  }
}
