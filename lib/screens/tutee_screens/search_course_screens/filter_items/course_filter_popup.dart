// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tutor_search_system/commons/colors.dart';
// import 'package:tutor_search_system/commons/styles.dart';
// import 'package:http/http.dart' as http;
// import 'package:tutor_search_system/models/class.dart';
// import 'package:tutor_search_system/models/subject.dart';
// import 'package:tutor_search_system/repositories/subject_repository.dart';
// import 'package:tutor_search_system/repositories/class_repository.dart';
// import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/filter_items/filter_item_popup.dart';
// import '../filter_models/filter_item.dart';

// //fee ranges list
// FeeRange range1 = FeeRange(1, 'Below \$25', '', false);
// FeeRange range2 = FeeRange(2, '\$25 - \$50', '', false);
// FeeRange range3 = FeeRange(3, 'Above \$50', '', false);
// //
// final feeRanges = [
//   range1,
//   range2,
//   range3,
// ];

// // week days list
// Weekday monday = Weekday(1, 'Monday', '', false);
// Weekday tuesday = Weekday(2, 'Tuesday', '', false);
// Weekday wednesday = Weekday(3, 'Wednesday', '', false);
// Weekday thusday = Weekday(4, 'Thusday', '', false);
// Weekday friday = Weekday(5, 'Friday', '', false);
// Weekday saturday = Weekday(6, 'Saturday', '', false);
// Weekday sunday = Weekday(7, 'Sunday', '', false);

// final weekdays = [
//   monday,
//   tuesday,
//   wednesday,
//   thusday,
//   friday,
//   saturday,
//   sunday,
// ];

// //gender list
// Gender male = Gender(1, 'Male', '', false);
// Gender female = Gender(2, 'Female', '', false);
// Gender other = Gender(3, 'Other', '', false);
// //
// final genders = [male, female, other];

// //subject load all ones from api and add them to List<Subject> as subUtem in filter item
// List<SubjectInFilter> subjectsList = [];
// //
// //Class load all ones from api and add them to List<Class> as subUtem in filter item
// List<ClassInFilter> classesList = [];
// //
// //education level load all ones from api and add them to List<education level> as subUtem in filter item
// EducationLevel college = EducationLevel(1, 'College', '', false);
// EducationLevel university = EducationLevel(2, 'University', '', false);
// EducationLevel master = EducationLevel(3, 'Master', '', false);
// EducationLevel professor = EducationLevel(4, 'Professor', '', false);
// //
// List<EducationLevel> educationLevels = [
//   college,
//   university,
//   master,
//   professor,
// ];

// //filter item constructor
// FilterItem studyTime = FilterItem('Study Time', '', weekdays, false);
// FilterItem studyFee = FilterItem('Study Fee', '', feeRanges, true);
// FilterItem daysInWeek = FilterItem('Days in week', '', weekdays, true);
// FilterItem beginEndDate =
//     FilterItem('Begin Date - End date', '', weekdays, false);
// //subject
// FilterItem subject = FilterItem('Subject', '', subjectsList, true);
// FilterItem classes = FilterItem('Class', '', classesList, true);
// FilterItem tutorGender = FilterItem('Gender', '', genders, true);
// FilterItem educationLevel =
//     FilterItem('Education Level', '', educationLevels, true);

// final List<FilterItem> filterCategory = [
//   studyTime,
//   studyFee,
//   daysInWeek,
//   beginEndDate,
//   subject,
//   classes,
//   tutorGender,
//   educationLevel,
// ];
// //

// class CourseFilterPopupDraft extends StatefulWidget {
//   @override
//   _CourseFilterPopupDraftState createState() => _CourseFilterPopupDraftState();
// }

// class _CourseFilterPopupDraftState extends State<CourseFilterPopupDraft> {
//   bool isResetable = false;
//   @override
//   Widget build(BuildContext context) {
//     //reset to default value all filter item in the filter.
//     void resetFilter() {
//       //reset to default value
//       //reset study time
//       studyTime.subTitle = '';
//       for (var item in studyTime.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset study fee
//       studyFee.subTitle = '';
//       for (var item in studyFee.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset study days in week
//       daysInWeek.subTitle = '';
//       for (var item in daysInWeek.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset subject
//       subject.subTitle = '';
//       for (var item in subject.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset classes
//       classes.subTitle = '';
//       for (var item in classes.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset tutor gender
//       tutorGender.subTitle = '';
//       for (var item in tutorGender.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //reset educationLevel
//       educationLevel.subTitle = '';
//       for (var item in educationLevel.subItems) {
//         if (item.isChecked) {
//           item.isChecked = !item.isChecked;
//         }
//       }
//       //refresh this page to update UI
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (BuildContext context) => super.widget));
//     }

//     //update subtitle by concat all subitem names
//     void updateSubtitle() {
//       //refresh subtitle; subtitle = concat of all subitem names
//       daysInWeek.subTitle = '';
//       for (var item in daysInWeek.subItems) {
//         if (item.isChecked) {
//           //set isResetable is true for showing reset button
//           setState(() {
//             isResetable = true;
//           });
//           //
//           if (daysInWeek.subTitle != '') {
//             daysInWeek.subTitle = daysInWeek.subTitle + ', ' + item.name;
//           } else {
//             daysInWeek.subTitle = daysInWeek.subTitle + item.name;
//           }
//         }
//       }
//       //set subtitle for tutor gender
//       tutorGender.subTitle = '';
//       for (var item in tutorGender.subItems) {
//         if (item.isChecked) {
//           //set isResetable is true for showing reset button
//           setState(() {
//             isResetable = true;
//           });
//           //
//           if (tutorGender.subTitle != '') {
//             tutorGender.subTitle = tutorGender.subTitle + ', ' + item.name;
//           } else {
//             tutorGender.subTitle = tutorGender.subTitle + item.name;
//           }
//         }
//       }
//       //set subtitle for study fee
//       studyFee.subTitle = '';
//       for (var item in studyFee.subItems) {
//         if (item.isChecked) {
//           //set isResetable is true for showing reset button
//           setState(() {
//             isResetable = true;
//           });
//           //
//           if (studyFee.subTitle != '') {
//             studyFee.subTitle = studyFee.subTitle + ', ' + item.name;
//           } else {
//             studyFee.subTitle = studyFee.subTitle + item.name;
//           }
//         }
//       }
//     }

// //---------------------------------------UI zone-----------------------------
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         elevation: 1,
//         title: Text(
//           'Filters',
//           style: titleStyle,
//         ),
//         centerTitle: true,
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               resetFilter();
//             },
//             child: Text(
//               'Reset',
//               style: textStyle,
//             ),
//           ),
//         ],
//         leading: IconButton(
//           icon: Icon(
//             Icons.close,
//             color: textGreyColor,
//             size: 20,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         child: ListView.separated(
//           separatorBuilder: (BuildContext context, int index) => Divider(),
//           itemCount: filterCategory.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               dense: true,
//               title: Container(
//                 padding: EdgeInsets.only(
//                   top: filterCategory[index].subTitle != '' ? 0 : 15,
//                 ),
//                 child: Text(
//                   filterCategory[index].title,
//                   style: TextStyle(
//                     fontSize: titleFontSize,
//                     color: filterCategory[index].subTitle != ''
//                         ? mainColor
//                         : textGreyColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               subtitle: Text(
//                 filterCategory[index].subTitle,
//                 style: TextStyle(
//                   fontSize: textFontSize,
//                   color: mainColor,
//                 ),
//               ),
//               trailing: Visibility(
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 15,
//                 ),
//                 visible: filterCategory[index].hasIcon,
//               ),
//               onTap: () async {
//                 //show time picker as a dialog
//                 if (filterCategory[index].title == 'Study Time') {
//                   showTimePicker(
//                     context: context,
//                     initialTime: TimeOfDay(hour: 10, minute: 47),
//                     builder: (BuildContext context, Widget child) {
//                       return MediaQuery(
//                         data: MediaQuery.of(context)
//                             .copyWith(alwaysUse24HourFormat: true),
//                         child: child,
//                       );
//                     },
//                   );
//                 }

//                 //show date picker when choose date begin and end date
//                 if (filterCategory[index].title == 'Begin Date - End date') {
//                   //show dialog DatePicker
//                   print('thí is datetime nơ: ' +
//                       DateTime.now().year.toString() +
//                       DateTime.now().month.toString() +
//                       DateTime.now().day.toString());
//                   showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     //get this date but a year later
//                     lastDate: DateTime.now().add(new Duration(
//                       days: 365,
//                     )),
//                   );
//                   return;
//                 }
//                 //
//                 if (filterCategory[index].title == 'Subject') {
//                   //remove all element in array
//                   filterCategory[index].subItems.clear();
//                   //get subject list from api
//                   final List<Subject> subjects =
//                       await SubjectRepository().fetchAllSubjects(http.Client());
//                   //
//                   for (var item in subjects) {
//                     filterCategory[index].subItems.add(new SubjectInFilter(
//                         item.id, item.name, item.description, false));
//                   }
//                   //
//                 } else if (filterCategory[index].title == 'Class') {
//                   //remove all element in array
//                   filterCategory[index].subItems.clear();
//                   //get class list from api
//                   final List<Class> classes =
//                       await ClassRepository().fetchAllClass(http.Client());
//                   //
//                   for (var item in classes) {
//                     filterCategory[index].subItems.add(new ClassInFilter(
//                         item.id, item.name, item.description, false));
//                   }
//                   //
//                 }
//                 //navigator to new page from right to left
//                 Route route = CupertinoPageRoute(
//                   builder: (context) => CourseFilterItemPopup(
//                     filterItem: filterCategory[index],
//                   ),
//                 );
//                 //
//                 Navigator.push(context, route).then(
//                   (value) => setState(() => {
//                         updateSubtitle(),
//                       }),
//                 );
//                 //
//               },
//             );
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: mainColor,
//         child: Container(
//           alignment: Alignment.center,
//           height: 50,
//           child: Text(
//             'See Results',
//             style: TextStyle(
//               color: backgroundColor,
//               fontSize: titleFontSize,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         elevation: 1,
//       ),
//     );
//   }
// }
