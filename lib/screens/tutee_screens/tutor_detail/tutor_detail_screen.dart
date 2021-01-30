import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}
