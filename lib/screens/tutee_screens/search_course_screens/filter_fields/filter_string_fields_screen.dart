import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/tutee_screens/search_course_screens/filter_models/filter_item.dart';

class FilterForStringFieldScreen extends StatefulWidget {
  final List<FilterItem> filterItems;
  final String header;
  final bool isMultipleSelectable;

  const FilterForStringFieldScreen(
      {Key key,
      @required this.filterItems,
      @required this.header,
      @required this.isMultipleSelectable})
      : super(key: key);
  @override
  _FilterForStringFieldScreenState createState() =>
      _FilterForStringFieldScreenState();
}

class _FilterForStringFieldScreenState
    extends State<FilterForStringFieldScreen> {
  //set all isSelected statuses are false
  void setDefaultStatusForAll() {
    for (var item in widget.filterItems) {
      item.isSelected = false;
    }
  }

  //apply all filter selections
  void apply() {
    //contain all selected items
    var selectedItems = [];
    //add selected items to list to return
    for (var item in widget.filterItems) {
      if (item.isSelected) {
        selectedItems.add(item.content);
      }
    }
    //
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        title: Text(
          widget.header,
          style: titleStyle,
        ),
        centerTitle: true,
        leading: buildDefaultBackButton(context),
        actions: [
          Visibility(
            visible: widget.isMultipleSelectable,
            child: TextButton(
              onPressed: () {
                apply();
              },
              child: Text(
                'Apply',
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: widget.filterItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Visibility(
                visible: widget.filterItems[index].isSelected,
                child: Icon(
                  Icons.check,
                  color: mainColor,
                  size: 15,
                ),
              ),
              title: Text(
                widget.filterItems[index].content,
                style: TextStyle(
                  color: widget.filterItems[index].isSelected
                      ? mainColor
                      : textGreyColor,
                  fontSize: titleFontSize,
                ),
              ),
              onTap: () {
                //
                if (widget.isMultipleSelectable) {
                  setState(() {
                    //set isSelected is true of false
                    widget.filterItems[index].isSelected =
                        !widget.filterItems[index].isSelected;
                  });
                } else {
                  //if this item is selected; do nothing
                  //if not set it selected
                  if (!widget.filterItems[index].isSelected) {
                    //clear all choices, because this is single choice
                    setDefaultStatusForAll();
                    //set isSelected is true
                    widget.filterItems[index].isSelected =
                        !widget.filterItems[index].isSelected;
                    //navigate to parent screen
                    Navigator.pop(context, widget.filterItems[index].content);
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
