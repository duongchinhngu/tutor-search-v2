// import 'package:flutter/material.dart';
// import 'package:tutor_search_system/commons/colors.dart';
// import 'package:tutor_search_system/commons/styles.dart';
// import '../filter_models/filter_item.dart';

// class CourseFilterItemPopup extends StatefulWidget {
//   final FilterItem filterItem;

//   const CourseFilterItemPopup({Key key, @required this.filterItem})
//       : super(key: key);
//   @override
//   _CourseFilterItemPopupState createState() => _CourseFilterItemPopupState();
// }

// class _CourseFilterItemPopupState extends State<CourseFilterItemPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: buildFilterAppBar(context),
//       body: Container(
//         child: ListView.separated(
//           separatorBuilder: (BuildContext context, int index) => Divider(),
//           itemCount: widget.filterItem.subItems.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               leading: Visibility(
//                 visible: widget.filterItem.subItems[index].isChecked,
//                 child: Icon(
//                   Icons.check,
//                   color: mainColor,
//                   size: 15,
//                 ),
//               ),
//               title: Text(
//                 widget.filterItem.subItems[index].name,
//                 style: TextStyle(
//                   color: widget.filterItem.subItems[index].isChecked
//                       ? mainColor
//                       : textGreyColor,
//                   fontSize: titleFontSize,
//                 ),
//               ),
//               onTap: () {
//                 setState(() {
//                   if (widget.filterItem.subItems[index].isChecked) {
//                     widget.filterItem.subTitle = widget.filterItem.subTitle
//                         .replaceFirst(
//                             widget.filterItem.subItems[index].name + ', ', '')
//                         .replaceFirst(
//                             widget.filterItem.subItems[index].name + ',', '')
//                         .replaceFirst(
//                             ', ' + widget.filterItem.subItems[index].name, '');
//                   } else {
//                     if (widget.filterItem.subTitle != '') {
//                       widget.filterItem.subTitle = widget.filterItem.subTitle +
//                           ', ' +
//                           widget.filterItem.subItems[index].name;
//                     } else {
//                       widget.filterItem.subTitle +=
//                           widget.filterItem.subItems[index].name;
//                     }
//                   }
//                   //
//                   widget.filterItem.subItems[index].isChecked =
//                       !widget.filterItem.subItems[index].isChecked;
//                   //
//                 });
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   //app bar
//   AppBar buildFilterAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: backgroundColor,
//       elevation: 1,
//       title: Text(
//         widget.filterItem.title,
//         style: titleStyle,
//       ),
//       centerTitle: true,
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: textGreyColor,
//           size: 15,
//         ),
//         onPressed: () => Navigator.pop(context),
//       ),
//     );
//   }
// }
