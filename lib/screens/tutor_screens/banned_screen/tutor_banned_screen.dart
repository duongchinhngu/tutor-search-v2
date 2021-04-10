import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorBannedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildSignOutButton(context),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: <Widget>[
            //welcome title
            _buildWelcomeLabel(),
            //illustration image
            buildIllustrationImage(),
            //explanation text field
            _buildExtraInformation(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      /// This is ignored if animatedIcon is non null
      icon: Icons.add,
      activeIcon: Icons.remove,
      // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
      /// The label of the main button.
      // label: Text("Open Speed Dial"),
      /// The active label of the main button, Defaults to label if not specified.
      // activeLabel: Text("Close Speed Dial"),
      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
      buttonSize: 56.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,

      /// If true overlay will render no matter what.
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black.withOpacity(.1),
      overlayOpacity: 0.5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      children: [
        SpeedDialChild(
          child: Icon(Icons.power_settings_new),
          backgroundColor: Colors.red,
          label: 'Sign out',
          labelBackgroundColor: Colors.white,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => showLogoutConfirmDialog(context),
        ),
        SpeedDialChild(
          child: Icon(Icons.support_agent),
          label: 'Support center',
          labelBackgroundColor: Colors.white,
          backgroundColor: Colors.blue,
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => launch('tel:0869631008'),
        ),
      ],
    );
  }

//extra info
  Widget _buildExtraInformation() {
    return Column(
      children: [
        //
        Container(
          child: Text(
            'Account does not have permission to enter site!',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: textGreyColor,
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        //explanation text field
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 10,
            bottom: 30,
          ),
          child: Text(
            'Your account status is Inactive now.\nPlease contact to Suppport Center for help.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Container buildIllustrationImage() {
    return Container(
      padding: EdgeInsets.only(
        top: 0,
        bottom: 20,
      ),
      child: Image.asset(
        'assets/images/depositphotos_9201509-stock-illustration-grunge-access-denied-rubber-stamp.jpg',
        height: 150,
      ),
    );
  }

  Container _buildWelcomeLabel() {
    return Container(
      padding: EdgeInsets.only(top: 110, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
          Text(
            'Illegal Access!',
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: textGreyColor,
                fontSize: headerFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
