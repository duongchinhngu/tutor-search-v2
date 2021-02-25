import 'package:flutter/material.dart';
import 'global_variables.dart' as globals;

//convert timeofday type to string value
String convertTimeOfDayToString(TimeOfDay time) {
  return globals.timeFormatter
      .format(new DateTime(1990, 1, 1, time.hour, time.minute, 0));
}

//convert timeOfDay type to string
// has format : yyyy-MM-ddThh:mm
// the same format as backend format
String convertTimeOfDayToAPIFormatString(TimeOfDay time) {
  return globals.defaultDatetime +
      'T' +
      globals.timeFormatter
          .format(new DateTime(1990, 1, 1, time.hour, time.minute, 0));
}

//convert DateTime type to string value
String convertDayTimeToString(DateTime date) {
  return globals.dateFormatter.format(date);
}
