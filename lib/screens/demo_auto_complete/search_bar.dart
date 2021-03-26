import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(hintColor: Colors.transparent),
      child: Container(
        height: 42,
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Color(0xFF757575), fontSize: 16)),
        ),
      ),
    );
  }
}
