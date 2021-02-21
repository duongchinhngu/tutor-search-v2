import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'create_course_screen.dart';

//weekday class and contructor
class Weekday {
  String label;
  bool isSelected;

  Weekday(this.label, this.isSelected);
}

//list of weeekdays for set status isSelected
var weekdays = [
  new Weekday('Mon', false),
  new Weekday('Tues', false),
  new Weekday('Wed', false),
  new Weekday('Thu', false),
  new Weekday('Fri', false),
  new Weekday('Sat', false),
  new Weekday('Sun', false),
];

//
//list of selected weekdays
var selectedWeekdays = [];

class WeekDaysComponent extends StatefulWidget {
  @override
  _WeekDaysComponentState createState() => _WeekDaysComponentState();
}

class _WeekDaysComponentState extends State<WeekDaysComponent> {
  @override
  void dispose() {
    // 
    selectedWeekdays.clear();
    //
    weekdays = [
      new Weekday('Mon', false),
      new Weekday('Tues', false),
      new Weekday('Wed', false),
      new Weekday('Thu', false),
      new Weekday('Fri', false),
      new Weekday('Sat', false),
      new Weekday('Sun', false),
    ];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      width: double.infinity,
      child: Wrap(
        runSpacing: 15,
        spacing: 20,
        children: [
          //monday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[0].isSelected = !weekdays[0].isSelected;
              });
              if (!weekdays[0].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[0].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[0].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[0].label,
              isSelected: weekdays[0].isSelected,
            ),
          ),
          //tuesday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[1].isSelected = !weekdays[1].isSelected;
              });
              if (!weekdays[1].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[1].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[1].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[1].label,
              isSelected: weekdays[1].isSelected,
            ),
          ),
          //wednesday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[2].isSelected = !weekdays[2].isSelected;
              });
              if (!weekdays[2].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[2].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[2].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[2].label,
              isSelected: weekdays[2].isSelected,
            ),
          ),
          //thusday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[3].isSelected = !weekdays[3].isSelected;
              });
              if (!weekdays[3].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[3].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[3].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[3].label,
              isSelected: weekdays[3].isSelected,
            ),
          ),
          //friday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[4].isSelected = !weekdays[4].isSelected;
              });
              if (!weekdays[4].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[4].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[4].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[4].label,
              isSelected: weekdays[4].isSelected,
            ),
          ),
          //saturday
          InkWell(
            onTap: () {
              setState(() {
                weekdays[5].isSelected = !weekdays[5].isSelected;
              });
              if (!weekdays[5].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[5].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[5].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[5].label,
              isSelected: weekdays[5].isSelected,
            ),
          ),
          //sun
          InkWell(
            onTap: () {
              setState(() {
                weekdays[6].isSelected = !weekdays[6].isSelected;
              });
              if (!weekdays[6].isSelected) {
                //remove
                selectedWeekdays.remove(weekdays[6].label);
              } else {
                //add new week date here
                selectedWeekdays.add(weekdays[6].label);
              }
              course.daysInWeek = selectedWeekdays.toString();
              print('this is days in weeke: ' + course.daysInWeek);
            },
            child: WeekDayButton(
              label: weekdays[6].label,
              isSelected: weekdays[6].isSelected,
            ),
          ),
        ],
      ),
    );
  }
}

//round weekday button
class WeekDayButton extends StatefulWidget {
  final String label;
  final bool isSelected;

  const WeekDayButton({Key key, @required this.label, this.isSelected}) : super(key: key);

  @override
  _WeekDayButtonState createState() => _WeekDayButtonState();
}

class _WeekDayButtonState extends State<WeekDayButton> {
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isSelected ? mainColor : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ]),
      child: Text(
        widget.label,
        style: TextStyle(
          fontSize: titleFontSize,
          color: widget.isSelected ? Colors.white : textGreyColor,
        ),
      ),
    );
  }
}

