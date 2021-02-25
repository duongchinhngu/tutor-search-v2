import 'package:tutor_search_system/commons/global_variables.dart';

class Name {
  
}

class FilterItem {
  final String content;
  bool isSelected;

  FilterItem(this.content, this.isSelected);
}

//---fee range list-----
final feeRange1 = FilterItem(feeRangeContent1, false);
final feeRange2 = FilterItem(feeRangeContent2, false);
final feeRange3 = FilterItem(feeRangeContent3, false);
//list fee range
List<FilterItem> feeRanges = [feeRange1, feeRange2, feeRange3];
// -----weekday list----
final monday = FilterItem('Monday', false);
final tuesday = FilterItem('Tuesday', false);
final wednesday = FilterItem('Wednesday', false);
final thusday = FilterItem('Thusday', false);
final friday = FilterItem('Friday', false);
final saturday = FilterItem('Saturday', false);
final sunday = FilterItem('Sunday', false);
//list weekdays
List<FilterItem> weekdays = [
  monday,
  tuesday,
  wednesday,
  thusday,
  friday,
  saturday,
  sunday
];
// --------gender-----------------
final genderAll = FilterItem('All', false);
final male = FilterItem(GENDER_MALE, false);
final female = FilterItem(GENDER_FEMALE, false);
// gender list
List<FilterItem> genders = [genderAll, male, female];
//---------education level---------
final educationLevelAll = FilterItem('All', false);
final colledge = FilterItem('Colledge', false);
final university = FilterItem('University', false);
final student = FilterItem('Student', false);
final teacher = FilterItem('Teacher', false);
//
List<FilterItem> educationLevels = [
  educationLevelAll,
  colledge,
  university,
  student,
  teacher
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
  for (var item in educationLevels) {
    item.isSelected = false;
  }
}
