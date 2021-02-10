//CircularProgress Indidcator for loading state
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tutor_search_system/commons/colors.dart';

Container buildLoadingIndicator() {
  return Container(
    color: backgroundColor,
    child: Center(
      // child: CircularProgressIndicator(
      //   backgroundColor: mainColor,
      // ),
      child: SpinKitWave(
        color: mainColor,
      ),
    ),
  );
}
