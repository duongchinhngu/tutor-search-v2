//----------------------------------------filter keys for search course page------------------------------

import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:tutor_search_system/models/class.dart';
import 'package:tutor_search_system/models/subject.dart';

//study fee filter---------------------------------
class FilterStudyFee {
  double from;
  double to;

  FilterStudyFee(this.from, this.to);
}

class FilterDistance {
  double from;
  double to;

  FilterDistance(this.from, this.to);
}

//--------Filter model contains all attributes of the system filter
class Filter {
  //study time filter----------------------
  TimeRange filterTimeRange;
  //distance
  FilterDistance filterDistance;
  //
  FilterStudyFee filterStudyFee;
//weeksday filter-------------------------------------
  String filterWeekdays;
  //begin end date =>  date range filter------------------------
  DateTimeRange filterDateRange;
//filter subject id-----------------------
  Subject filterSubject;
//class filter---------------------
  Class filterClass;
//gender filter------------------------------
  String filterGender;
// //education level filter-------------------------------
//   String filterEducationLevel;

  Filter(
      this.filterTimeRange,
      this.filterDistance,
      this.filterStudyFee,
      this.filterWeekdays,
      this.filterDateRange,
      this.filterClass,
      this.filterGender,
      );
//
  //reset to default value
  void resetFilterVariables() {
    filterStudyFee = null;
    filterDistance = null;
    filterDateRange = null;
    filterGender = null;
    filterStudyFee = null;
    filterTimeRange = null;
    filterWeekdays = '';
  }

// --------------------- course filter variables function ----------
  int countSelectedFilterItems() {
    int count = 0;
    if (filterTimeRange != null) {
      count += 1;
    }
    if (filterStudyFee != null) {
      count += 1;
    }
    if (filterWeekdays.isNotEmpty) {
      count += 1;
    }
    if (filterDateRange != null) {
      count += 1;
    }
    if (filterDistance != null) {
      count += 1;
    }
    if (filterGender != null) {
      count += 1;
    }

    return count;
  }
}

Filter filter = Filter(null, null, null, '', null, null, null);
