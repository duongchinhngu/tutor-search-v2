import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';

//alert dialog when there is an empty required field
  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
                          title: Container(
                            width: double.infinity,
                            // height: 70,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/sad.png',
                              height: 70,
                              width: 170,
                            ),
                          ),
                          content: Container(
                            width: double.infinity,
                            height: 20,
                            alignment: Alignment.center,
                            child: Text(
                              'There is an empty required field!',
                              style: textStyle,
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: mainColor, // background
                                onPrimary: textWhiteColor, // foreground
                                elevation: 1.0,
                              ),
                              child: Center(
                                // width: double.infinity

                                child: Text('Ok'),
                              ),
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(),
                            )
                          ],
                        );
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
