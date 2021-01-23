import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'filter_item_popup.dart';

//this class for category item( contains filter values to search inside)
class FilterItem {
  String title;
  String subTitle;
  final List<SubItems> subItems;
  bool hasIcon;

  FilterItem(
    this.title,
    this.subTitle,
    this.subItems,
    this.hasIcon,
  );
}

abstract class SubItems {
  String name;
  String description;
  bool isChecked;

  SubItems(
    this.name,
    this.description,
    this.isChecked,
  );
}

//gender list
class Gender extends SubItems {
  Gender(String name, String description, bool isChecked) : super(name, description, isChecked);
}

//days in week
class Weekday extends SubItems {
  Weekday(String name, String description, bool isChecked)
      : super(name, description, isChecked);
}

Weekday monday = Weekday('Monday', '', false);
Weekday tuesday = Weekday('Tuesday', '', false);
Weekday wednesday = Weekday('Wednesday', '', false);
Weekday thusday = Weekday('Thusday', '', false);
Weekday friday = Weekday('Friday', '', false);
Weekday saturday = Weekday('Saturday', '', false);
Weekday sunday = Weekday('Sunday', '', false);

final weekdays = [
  monday,
  tuesday,
  wednesday,
  thusday,
  friday,
  saturday,
  sunday,
];
//genders list
Gender male = Gender('Male', '', false);
Gender female = Gender('Female', '', false);
Gender other = Gender('Other', '', false);
//
final genders = [male, female, other];

//filter item constructor
FilterItem studyTime = FilterItem('Study Time', '', weekdays, false);
FilterItem studyFee = FilterItem('Study Fee', 'expensive', weekdays, true);
FilterItem daysInWeek = FilterItem('Days in week', '', weekdays, true);
FilterItem beginEndDate =
    FilterItem('Begin Date - End date', '', weekdays, false);
//subject
FilterItem subject = FilterItem('Subject', '', weekdays, true);
FilterItem classes = FilterItem('Class', '', weekdays, true);
FilterItem tutorGender = FilterItem('Gender', '', genders, true);
FilterItem educationLevel = FilterItem('Education Level', '', weekdays, true);

final List<FilterItem> filterCategory = [
  studyTime,
  studyFee,
  daysInWeek,
  beginEndDate,
  subject,
  classes,
  tutorGender,
  educationLevel,
];

class CourseFilterPopup extends StatefulWidget {
  @override
  _CourseFilterPopupState createState() => _CourseFilterPopupState();
}

class _CourseFilterPopupState extends State<CourseFilterPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        title: Text(
          'Filters',
          style: titleStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.red[300],
            onPressed: () {},
            child: Text(
              'Reset',
              style: textStyle,
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: textGreyColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: filterCategory.length,
          itemBuilder: (BuildContext context, int index) {
            if (filterCategory[index].subTitle != '') {
              return ListTile(
                title: Text(
                  filterCategory[index].title,
                  style: titleStyle,
                ),
                subtitle: Text(
                  filterCategory[index].subTitle,
                  style: textStyle,
                ),
                trailing: Visibility(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                  visible: filterCategory[index].hasIcon,
                ),
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CourseFilterItemPopup(
                      filterItem: filterCategory[index],
                    ),
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text(
                  filterCategory[index].title,
                  style: titleStyle,
                ),
                trailing: Visibility(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                  visible: filterCategory[index].hasIcon,
                ),
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CourseFilterItemPopup(
                      filterItem: filterCategory[index],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: mainColor,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            'See Results',
            style: TextStyle(
              color: backgroundColor,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 1,
      ),
    );
  }
}
