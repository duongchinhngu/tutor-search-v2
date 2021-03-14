import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_profile/tutee_profile_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_register_screens/tutee_register_screen.dart';

class UpdateTuteeProfile extends StatefulWidget {
  @override
  _UpdateTuteeProfileState createState() => _UpdateTuteeProfileState();
}

class _UpdateTuteeProfileState extends State<UpdateTuteeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: buildDefaultCloseButton(context),
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TuteeProfileManagement(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.blue[900]),
                  ),
                  child: Center(
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                          color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            //Containner Avarta
            // Container(
            //   padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            //   child: CircleAvatar(
            //     radius: 65,
            //     backgroundImage: NetworkImage(
            //         // state.tutor.avatarImageLink,
            //         'http://www.gstatic.com/tv/thumb/persons/528854/528854_v9_bb.jpg'),
            //   ),

            // )
            Container(
              height: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //circle blue box behind the circle avatar
                  Container(
                    height: 175,
                    width: 175,
                    decoration: BoxDecoration(
                      color: Colors.blue[500].withOpacity(0.35),
                      shape: BoxShape.circle,
                    ),
                  ),
                  //avartar
                  CircleAvatar(
                    foregroundColor: Colors.green,
                    radius: 80,
                    backgroundImage: avatarImage != null
                        ? FileImage(
                            avatarImage,
                          )
                        : NetworkImage(
                            //         // state.tutor.avatarImageLink,
                            'http://www.gstatic.com/tv/thumb/persons/528854/528854_v9_bb.jpg'),
                  ),
                  //edit avartar icon
                  Positioned(
                    bottom: 40,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[500].withOpacity(0.35),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
