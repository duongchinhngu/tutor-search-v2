import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';

class AddTargetScreen extends StatefulWidget {
  @override
  _AddTargetScreenState createState() => _AddTargetScreenState();
}

class _AddTargetScreenState extends State<AddTargetScreen> {
  //
  List<String> targets = [];
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [buildDefaultCloseButton(context)],
      ),
      body: Column(
        children: [
          //
          GestureDetector(
            onTap: () {
              TextEditingController targetController = TextEditingController();
              GlobalKey<FormState> _formKey = GlobalKey<FormState>();
              //
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                      backgroundColor: backgroundColor,
                      elevation: 1.0,
                      insetAnimationCurve: Curves.ease,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Container(
                            height: 350,
                            width: 200,
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //title
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Text(
                                    'Target for this course',
                                    style: titleStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                //text field
                                Container(
                                  height: 200,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.only(right: 20, bottom: 20),
                                  margin: EdgeInsets.only(
                                      left: 20, top: 20, bottom: 0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    expands: true,
                                    maxLength: 500,
                                    maxLines: null,
                                    controller: targetController,
                                    textAlign: TextAlign.start,
                                    onChanged: (context) {},
                                    decoration: InputDecoration(
                                      filled: true,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0.0),
                                      ),
                                      hintText:
                                          'What you want your tutee gain from this course!?',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: textFontSize,
                                      ),
                                    ),
                                    validator: RequiredValidator(
                                        errorText: 'is required'),
                                  ),
                                ),
                                //actions
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Cancel
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: textFontSize + 1,
                                          )),
                                    ),
                                    //ok
                                    TextButton(
                                      onPressed: () {
                                        //
                                        if (_formKey.currentState.validate()) {
                                          //
                                          setState(() {
                                            targets.add(targetController.text);
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: textFontSize + 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )));
            },
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              child: Text(
                'Add target',
                style: TextStyle(
                  fontSize: titleFontSize,
                  color: mainColor,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: mainColor),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          //
          Column(
            children: List.generate(targets.length, (index) {
              return ListTile(
                leading: Icon(
                  Icons.drag_handle,
                  size: 25,
                  color: Colors.red[300],
                ),
                title: Text(
                  targets[index],
                ),
                trailing: Icon(
                  Icons.more_vert_outlined,
                  size: 25,
                  color: Colors.red[300],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
