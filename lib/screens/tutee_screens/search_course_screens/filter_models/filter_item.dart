import 'package:tutor_search_system/commons/common_model.dart';
import 'package:tutor_search_system/commons/global_variables.dart';

class FilterItem extends SelectableObject {
  FilterItem(String content, bool isSelected) : super(content, isSelected);
}

//----study form list-----
final _online = FilterItem('Online', false);
final _tuteeHome = FilterItem('Tutee Home', false);
//
List<FilterItem> studyForms = [
  _online,
  _tuteeHome,
];
//---fee range list-----
final _feeRange1 = FilterItem(feeRangeContent1, false);
final _feeRange2 = FilterItem(feeRangeContent2, false);
final _feeRange3 = FilterItem(feeRangeContent3, false);
//list fee range
List<FilterItem> feeRanges = [_feeRange1, _feeRange2, _feeRange3];
// -----weekday list----
final _monday = FilterItem('Monday', false);
final _tuesday = FilterItem('Tuesday', false);
final _wednesday = FilterItem('Wednesday', false);
final _thusday = FilterItem('Thusday', false);
final _friday = FilterItem('Friday', false);
final _saturday = FilterItem('Saturday', false);
final _sunday = FilterItem('Sunday', false);
//list weekdays
List<FilterItem> weekdays = [
  _monday,
  _tuesday,
  _wednesday,
  _thusday,
  _friday,
  _saturday,
  _sunday
];
// --------gender-----------------
final _genderAll = FilterItem('All', false);
final _male = FilterItem(GENDER_MALE, false);
final _female = FilterItem(GENDER_FEMALE, false);
// gender list
List<FilterItem> genders = [
  _genderAll,
  _male,
  _female,
];

//---reset to default value--------
void resetToDefaultValue() {
  //
  for (var item in feeRanges) {
    item.isSelected = false;
  }
//
  for (var item in weekdays) {
    item.isSelected = false;
  }
//
  for (var item in genders) {
    item.isSelected = false;
  }
  //
  for (var item in studyForms) {
    item.isSelected = false;
  }
}
