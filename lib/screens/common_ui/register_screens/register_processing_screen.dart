import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/common_functions.dart';
import 'package:tutor_search_system/models/account.dart';
import 'package:tutor_search_system/models/tutee.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/account_repository.dart';
import 'package:tutor_search_system/repositories/image_repository.dart';
import 'package:tutor_search_system/repositories/tutee_repository.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';
import 'package:tutor_search_system/screens/common_ui/login_screen.dart';
import 'package:tutor_search_system/screens/common_ui/register_screens/tutee_register_screens/tutee_register_variables.dart';
import 'package:tutor_search_system/screens/common_ui/register_screens/tutor_register_screens/tutor_register_successfully.dart';
import 'package:tutor_search_system/screens/common_ui/register_screens/tutor_register_screens/tutor_register_variables.dart';
import '../error_screen.dart';
import './tutee_register_screens/tutee_register_screen.dart' as tutee_screen;
import './tutor_register_screens/tutor_register_screen.dart' as tutor_screen;
import 'package:tutor_search_system/models/image.dart' as image;

////processing REgister tutee
class TuteeRegisterProccessingScreen extends StatefulWidget {
  final Tutee tutee;

  const TuteeRegisterProccessingScreen({Key key, this.tutee}) : super(key: key);
  @override
  _TuteeRegisterProccessingScreenState createState() =>
      _TuteeRegisterProccessingScreenState();
}

class _TuteeRegisterProccessingScreenState
    extends State<TuteeRegisterProccessingScreen> {
  //
  final tuteeRepository = TuteeRepository();
  //
  final accountRepository = AccountRepository();

  Future<bool> registerTutee(Tutee tutee) async {
    //
    tutee.fullname = tutee_screen.nameController.text;
    tutee.gender = tutee_screen.genderController.text;
    tutee.birthday = tutee_screen.birthdayController.text;
    tutee.email = tutee_screen.emailController.text;
    tutee.phone = tutee_screen.phoneController.text;
    tutee.address = tutee_screen.addressController.text;
    //need to refactor
    //after post image on Firebase; get link and set to tutee
    if (tutee_screen.avatarImage != null) {
      var imageUrl =
          await uploadFileOnFirebaseStorage(tutee_screen.avatarImage);
      tutee.avatarImageLink = imageUrl;
    }

    //post course
    await tuteeRepository.postTutee(tutee);
    //init account obj
    final account =
        Account.constructor(0, tutee.email, tutee.roleId, '', 'Active');
    account.showAttribute();
    //post Account
    await accountRepository.postAcount(account);
    return Future.value(true);
  }

  //
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: registerTutee(widget.tutee),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            //reset to defaul value of tuee
            resetRegisterTutee();
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LoginScreen(
                          snackBarIcon: Icons.check_circle_outline_outlined,
                          snackBarTitle: 'Registered successfully',
                          snackBarContent: 'Login to explore now!',
                          snackBarThemeColor: Colors.green.shade600,
                        )),
                ModalRoute.withName('/Home'),
              );
            });
            return Container();
          } else {
            return Container(
              color: backgroundColor,
              child: SpinKitWave(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}

//processing REgister tutor
class TutorRegisterProccessingScreen extends StatefulWidget {
  final Tutor tutor;

  const TutorRegisterProccessingScreen({Key key, this.tutor}) : super(key: key);
  @override
  _TutorRegisterProccessingScreenState createState() =>
      _TutorRegisterProccessingScreenState();
}

class _TutorRegisterProccessingScreenState
    extends State<TutorRegisterProccessingScreen> {
  //
  final tutorRepository = TutorRepository();
  //
  final imageRepository = ImageRepository();
  //
  Future<bool> registerTutor(Tutor tutor) async {
    tutor.fullname = tutor_screen.nameController.text;
    tutor.gender = tutor_screen.genderController.text;
    tutor.birthday = tutor_screen.birthdayController.text;
    tutor.email = tutor_screen.emailController.text;
    tutor.phone = tutor_screen.phoneController.text;
    tutor.address = tutor_screen.addressController.text;
    tutor.educationLevel = tutor_screen.educationLevelController.text;
    tutor.school = tutor_screen.schoolController.text;

    //need to refactor
    //after post image on Firebase; get link and set to tutor
    if (avatarImage != null) {
      var imageUrl = await uploadFileOnFirebaseStorage(avatarImage);
      tutor.avatarImageLink = imageUrl;
    }
    if (socialIdImage != null) {
      var imageUrl = await uploadFileOnFirebaseStorage(socialIdImage);
      tutor.socialIdUrl = imageUrl;
    }

    //post tutor
    await tutorRepository.postTutor(tutor);
    //post Image to DB
    if (certificationImages.length > 1) {
      //remove ADD image icon File in default certification image list
      certificationImages.remove(certificationImages.first);
      //
      for (var certitfication in certificationImages) {
        var imageUrl = await uploadFileOnFirebaseStorage(certitfication);
        // post certification url to Image table in DB
        imageRepository.postImage(
          new image.Image.constructor(
              0, imageUrl, 'certification', tutor.email),
        );
      }
    }
    return Future.value(true);
  }

  //
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: registerTutor(widget.tutor),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        } else {
          if (snapshot.hasData == true) {
            //reset to defaul value of tuee
            resetRegisterTutor();
            //
            WidgetsBinding.instance.addPostFrameCallback((_) {
              return Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => TutorRegisterSuccessfullyScreen()),
                ModalRoute.withName('/Home'),
              );
            });
            return Container();
          } else {
            return Container(
              color: backgroundColor,
              child: SpinKitWave(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
