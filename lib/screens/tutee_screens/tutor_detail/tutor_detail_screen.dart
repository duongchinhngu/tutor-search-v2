import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';

class TutorDetails extends StatefulWidget {
  @override
  _TutorDetailsState createState() => _TutorDetailsState();
}

class _TutorDetailsState extends State<TutorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Container(),
          ),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
