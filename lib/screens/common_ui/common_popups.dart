//show modal and choose begin and end time
  import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:tutor_search_system/commons/colors.dart';

//show default timerange picker
Future<TimeRange> timeRangeSelector(BuildContext context, String centerLabel) async {
    return await showTimeRangePicker(
      context: context,
      padding: 30,
      interval: Duration(minutes: 10),
      strokeWidth: 10,
      handlerRadius: 10,
      strokeColor: mainColor,
      handlerColor: mainColor,
      selectedColor: Colors.red[900],
      backgroundWidget: Text(
        centerLabel,
        style: GoogleFonts.kaushanScript(
          textStyle: TextStyle(
            color: mainColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ticks: 12,
      ticksColor: Colors.white,
      snap: true,
      labels: [
        ClockLabel(angle: 270.0 * pi / 180, text: '12AM'),
        ClockLabel(angle: 00.0, text: '6PM'),
        ClockLabel(angle: 90.0 * pi / 180, text: 'Midnight'),
        ClockLabel(angle: 180.0 * pi / 180, text: '6AM')
      ],
    );
  }

    //get date range and get end and start date
  Future<DateTimeRange> dateRangeSelector(BuildContext context) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        new Duration(
          days: 365,
        ),
      ),
    );
  }
