//CircularProgress Indidcator for loading state
import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';

Container buildLoadingIndicator() {
  return Container(
    color: backgroundColor,
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: mainColor,
      ),
    ),
  );
}
