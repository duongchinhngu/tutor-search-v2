import 'package:flutter/material.dart';
import 'global_variables.dart' as globals;

//convert timeofday type to string value
String convertTimeOfDayToString(TimeOfDay time) {
  return globals.timeFormatter
      .format(new DateTime(1990, 1, 1, time.hour, time.minute, 0));
}

//convert DateTime type to string value
String convertDayTimeToString(DateTime date) {
  return globals.dateFormatter.format(date);
}