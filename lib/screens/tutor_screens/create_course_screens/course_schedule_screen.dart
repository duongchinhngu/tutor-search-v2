import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/course_schedule/preview_course_schedule.dart';

List<String> learningPlan = [];
TextEditingController commentController = TextEditingController();
TextEditingController editController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
List<String> list = [];

class CourseScheduleScreen extends StatefulWidget {
  final int numberOfWeek;

  const CourseScheduleScreen({Key key, @required this.numberOfWeek})
      : super(key: key);

  @override
  _CourseScheduleScreenState createState() => _CourseScheduleScreenState();
}

class _CourseScheduleScreenState extends State<CourseScheduleScreen> {
  int weekIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: Container(
        child: Column(
          children: [
            buildBodyV2(),
            Container(
              child: Container(
                  width: 400,
                  height: 460,
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      Container(
                          width: 400,
                          margin: EdgeInsets.fromLTRB(90, 20, 90, 0),
                          child: Text('Study Plan - Week 1',
                              style: TextStyle(
                                  color: textGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                      Container(
                        width: 400,
                        height: 350,
                        child: _buildItemPlan(),
                      ),
                      buildAddPlan(context),
                    ],
                  )),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FloatingActionButton buildAddPlan(BuildContext context) =>
      FloatingActionButton.extended(
          onPressed: () {
            _showInputPlanDialog(context);
          },
          label: Text(
            'Add new Plan',
            style: TextStyle(
                fontSize: titleFontSize,
                color: mainColor,
                fontWeight: FontWeight.bold),
          ),
          isExtended: true,
          backgroundColor: Colors.white);

  _showInputPlanDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              elevation: 1.0,
              insetAnimationCurve: Curves.ease,
              child: _dialogWidget(),
            ));
  }

  _showEditInputDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              elevation: 1.0,
              insetAnimationCurve: Curves.ease,
              child: _editDialogWidget(),
            ));
  }

  Container _buildTitle() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      alignment: Alignment.center,
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //feedback icon
          //label
          Text(
            'Content of learning',
            style: TextStyle(
              fontSize: headerFontSize,
              fontWeight: FontWeight.bold,
              color: defaultBlueTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editDialogWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(),
            Container(
              height: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10, bottom: 0),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                readOnly: isSending,
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLength: 500,
                maxLines: null,
                controller: editController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  fillColor: Color(0xffF9F2F2),
                  filled: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  counter: Text(''),
                  hintText: 'Write the plan/content of learning...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: textFontSize,
                  ),
                ),
                validator: RequiredValidator(errorText: 'is required'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    list.add(commentController.text);
                    learningPlan = list;
                    commentController.text = '';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: 94,
                  height: 38,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mainColor,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: textWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTitle(),
            Container(
              height: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10, bottom: 0),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                readOnly: isSending,
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLength: 500,
                maxLines: null,
                controller: commentController,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  fillColor: Color(0xffF9F2F2),
                  filled: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0.0),
                  ),
                  counter: Text(''),
                  hintText: 'Write the plan/content of learning...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: textFontSize,
                  ),
                ),
                validator: RequiredValidator(errorText: 'is required'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    list.add(commentController.text);
                    learningPlan = list;
                    commentController.text = '';
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: 94,
                  height: 38,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mainColor,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: textWhiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildWeekPlanItem(String content, String title, IconData icon,
      IconData editIcon, int index) {
    return ListTile(
      leading: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: mainColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
      ),
      subtitle: Text(
        content,
        style: TextStyle(
          fontSize: titleFontSize,
          color: textGreyColor,
        ),
      ),
      trailing: Container(
        child: PopupMenuButton(
          child: Icon(
            editIcon,
          ),
          itemBuilder: (context) {
            return <PopupMenuItem>[
              PopupMenuItem(
                child: TextButton(
                  child: Text('Edit'),
                  onPressed: () {
                    setState(() {
                      editController.text = learningPlan[index];
                      _showEditInputDialog(context);
                    });
                  },
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Remove'),
                  onPressed: () {},
                ),
              )
            ];
          },
        ),
      ),
    );
  }

  Widget _buildItemPlan() {
    return ListView.builder(
        itemCount: learningPlan.length,
        itemBuilder: (context, index) => Column(
              children: [
                buildWeekPlanItem(learningPlan[index], 'Content ' + '$index',
                    Icons.check_outlined, Icons.more_vert, index),
                buildDivider(),
              ],
            ));
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      focusColor: Colors.transparent,
      focusElevation: 0,
      highlightElevation: 0,
      splashColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      onPressed: () {
        //
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => UpdateTuteeProfile(),
        //   ),
        // );
      },
      label: Container(
        margin: EdgeInsetsDirectional.only(
          bottom: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
        ),
        width: 341,
        height: 88,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //
            Container(
              width: 140,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
                color: backgroundColor,
              ),
              child: FlatButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewCourseSchedule(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: mainColor,
                ),
                label: Text(
                  'Preview',
                  style: TextStyle(
                    color: mainColor,
                  ),
                ),
              ),
            ),
            //
            Container(
              width: 140,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1,
                  color: mainColor,
                ),
                color: mainColor,
              ),
              child: FlatButton.icon(
                onPressed: () {
                  if (weekIndex == widget.numberOfWeek) {
                  } else {
                    setState(() {
                      weekIndex += 1;
                    });
                  }
                },
                icon: Icon(
                  Icons.next_plan,
                  color: backgroundColor,
                ),
                label: Text(
                  'Next',
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: titleFontSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Schedule in ' + widget.numberOfWeek.toString() + ' week(s)',
        style: TextStyle(color: textGreyColor),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: textGreyColor,
          ),
          onPressed: () {
            if (weekIndex == 1) {
              Navigator.pop(context);
            }
            setState(() {
              weekIndex -= 1;
            });
          }),
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            size: 22,
            color: textGreyColor,
          ),
          onPressed: () {
            //
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Container buildBodyV2() {
    return Container(
        child: StepProgressIndicator(
      totalSteps: widget.numberOfWeek,
      currentStep: weekIndex,
      selectedColor: Colors.green,
      unselectedColor: Colors.grey.withOpacity(0.7),
    ));
  }
}
