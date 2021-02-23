import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';

//default back button
IconButton buildDefaultBackButton(BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.arrow_back_ios,
      color: textGreyColor,
      size: 15,
    ),
    onPressed: () => Navigator.pop(context),
  );
}

//default close button
IconButton buildDefaultCloseButton(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.close,
          color: textGreyColor,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      );
  }