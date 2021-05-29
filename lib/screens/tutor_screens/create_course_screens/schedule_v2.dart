import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutor_screens/course_schedule/preview_course_schedule.dart';

List<String> listWeek = [];
TextEditingController planController = TextEditingController();
TextEditingController editPlanController = TextEditingController();
TextEditingController learningOutcomeController = TextEditingController();
TextEditingController editLearningOutcomeController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

List<CourseDetail> listCourseDetail = [];
List<CourseDetail> listPlan = [];
List<CourseDetail> listOutcome = [];
CourseDetail courseDetail = CourseDetail('', '', '');

class CourseScheduleScreenV2 extends StatefulWidget {
  final int numberOfWeek;
  final Subject subject;
  final List<CourseDetail> plan;
  final List<CourseDetail> outcome;

  const CourseScheduleScreenV2(
      {Key key,
      @required this.numberOfWeek,
      this.subject,
      this.plan,
      this.outcome})
      : super(key: key);

  @override
  _CourseScheduleScreenV2State createState() => _CourseScheduleScreenV2State();
}

class _CourseScheduleScreenV2State extends State<CourseScheduleScreenV2>
    with TickerProviderStateMixin {
  int selectedPageIndex = 0;
  TabController _tabController;
  int weekIndex = 1;
  String week = '';

  @override
  void initState() {
    _tabController = new TabController(
      vsync: this,
      length: widget.numberOfWeek,
      initialIndex: selectedPageIndex,
    );
    if (widget.plan.length > 0 && widget.outcome.length > 0) {
      listOutcome = widget.outcome;
      listPlan = widget.plan;
    } else {
      listOutcome = [];
      listPlan = [];
    }

    listWeek = [];
    listCourseDetail = [];
    listWeek.add('Week $weekIndex');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context),
      body: ListView(
        children: [
          StepProgressIndicator(
            totalSteps: widget.numberOfWeek,
            currentStep: weekIndex,
            selectedColor: Colors.green,
            unselectedColor: Colors.grey.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Container(
                width: 400,
                margin: EdgeInsets.fromLTRB(90, 20, 90, 0),
                child: Text('Study Plan - Week $weekIndex',
                    style: TextStyle(
                        color: textGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          ),
          buildBodyV2(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  //floating action button
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
                  for (int i = 0; i < listCourseDetail.length; i++) {
                    if (listCourseDetail[i].period == 'Week $weekIndex') {
                      listCourseDetail.remove(listCourseDetail[i]);
                    }
                  }
                  if (listPlan.length <= 0 || listOutcome.length <= 0) {
                    showDialog(
                        context: context,
                        builder: (context) => buildDefaultDialog(
                                context,
                                'Cannot Preview',
                                'All week must be filled the plan and the learning outcome!',
                                [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK')),
                                ]));
                  } else {
                    bool checkEmptyPlan = true;
                    bool checkEmptyOutcome = true;
                    for (int i = 0; i < listPlan.length; i++) {
                      if (listPlan[i].period == 'Week $weekIndex') {
                        checkEmptyPlan = false;
                      }
                    }
                    for (int i = 0; i < listOutcome.length; i++) {
                      if (listOutcome[i].period == 'Week $weekIndex') {
                        checkEmptyOutcome = false;
                      }
                    }
                    if (checkEmptyOutcome == false && checkEmptyPlan == false) {
                      String plan = '';
                      String outcome = '';
                      for (int i = 0; i < listPlan.length; i++) {
                        if (listPlan[i].period == 'Week $weekIndex')
                          plan = plan + listPlan[i].schedule + '\n';
                      }
                      for (int i = 0; i < listOutcome.length; i++) {
                        if (listOutcome[i].period == 'Week $weekIndex')
                          outcome =
                              outcome + listOutcome[i].learningOutcome + '\n';
                      }
                      CourseDetail newCourseDetail =
                          CourseDetail('Week $weekIndex', plan, outcome);
                      listCourseDetail.add(newCourseDetail);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreviewCourseSchedule(
                            listSchedule: listCourseDetail,
                            listweek: listWeek,
                            subject: widget.subject,
                            numOfWeek: widget.numberOfWeek,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => buildDefaultDialog(
                                  context,
                                  'Cannot Preview',
                                  'All week must be filled the plan and the learning outcome!',
                                  [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK')),
                                  ]));
                    }
                  }
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
            weekIndex != widget.numberOfWeek
                ? Container(
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
                            //set for progress indicator
                            for (int i = 0; i < listCourseDetail.length; i++) {
                              if (listCourseDetail[i].period ==
                                  'Week $weekIndex') {
                                listCourseDetail.remove(listCourseDetail[i]);
                              }
                            }
                            bool checkEmptyPlan = true;
                            bool checkEmptyOutcome = true;
                            for (int i = 0; i < listPlan.length; i++) {
                              if (listPlan[i].period == 'Week $weekIndex') {
                                checkEmptyPlan = false;
                              }
                            }
                            for (int i = 0; i < listOutcome.length; i++) {
                              if (listOutcome[i].period == 'Week $weekIndex') {
                                checkEmptyOutcome = false;
                              }
                            }
                            if (checkEmptyOutcome == false &&
                                checkEmptyPlan == false) {
                              String plan = '';
                              String outcome = '';
                              for (int i = 0; i < listPlan.length; i++) {
                                if (listPlan[i].period == 'Week $weekIndex')
                                  plan = plan + listPlan[i].schedule + '\n';
                              }
                              for (int i = 0; i < listOutcome.length; i++) {
                                if (listOutcome[i].period == 'Week $weekIndex')
                                  outcome = outcome +
                                      listOutcome[i].learningOutcome +
                                      '\n';
                              }
                              CourseDetail newCourseDetail = CourseDetail(
                                  'Week $weekIndex', plan, outcome);
                              listCourseDetail.add(newCourseDetail);
                              weekIndex += 1;
                              //set for page view index
                              bool dup = false;
                              for (int i = 0; i < listWeek.length; i++) {
                                if (listWeek[i] == 'Week $weekIndex') {
                                  dup = true;
                                }
                              }
                              if (dup == false) {
                                listWeek.add('Week $weekIndex');
                              }
                              selectedPageIndex += 1;
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => buildDefaultDialog(
                                          context,
                                          'Cannot Next',
                                          'All week must be filled the plan and the learning outcome!',
                                          [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK')),
                                          ]));
                            }
                          });
                          planController.text = '';
                          learningOutcomeController.text = '';
                          _tabController.animateTo(selectedPageIndex);
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
                  )
                : Container(
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
                        for (int i = 0; i < listCourseDetail.length; i++) {
                          if (listCourseDetail[i].period == 'Week $weekIndex') {
                            listCourseDetail.remove(listCourseDetail[i]);
                          }
                        }
                        if (listPlan.length <= 0 || listOutcome.length <= 0) {
                          showDialog(
                              context: context,
                              builder: (context) => buildDefaultDialog(
                                      context,
                                      'Cannot Preview',
                                      'All week must be filled the plan and the learning outcome!',
                                      [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('OK')),
                                      ]));
                        } else {
                          bool checkEmptyPlan = true;
                          bool checkEmptyOutcome = true;
                          for (int i = 0; i < listPlan.length; i++) {
                            if (listPlan[i].period == 'Week $weekIndex') {
                              checkEmptyPlan = false;
                            }
                          }
                          for (int i = 0; i < listOutcome.length; i++) {
                            if (listOutcome[i].period == 'Week $weekIndex') {
                              checkEmptyOutcome = false;
                            }
                          }
                          if (checkEmptyOutcome == false &&
                              checkEmptyPlan == false) {
                            String plan = '';
                            String outcome = '';
                            for (int i = 0; i < listPlan.length; i++) {
                              if (listPlan[i].period == 'Week $weekIndex')
                                plan = plan + listPlan[i].schedule + '\n';
                            }
                            for (int i = 0; i < listOutcome.length; i++) {
                              if (listOutcome[i].period == 'Week $weekIndex')
                                outcome = outcome +
                                    listOutcome[i].learningOutcome +
                                    '\n';
                            }
                            CourseDetail newCourseDetail =
                                CourseDetail('Week $weekIndex', plan, outcome);
                            listCourseDetail.add(newCourseDetail);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PreviewCourseSchedule(
                                  listSchedule: listCourseDetail,
                                  listweek: listWeek,
                                  subject: widget.subject,
                                  numOfWeek: widget.numberOfWeek,
                                  listPlan: listPlan,
                                  listOutcome: listOutcome,
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => buildDefaultDialog(
                                        context,
                                        'Cannot Preview',
                                        'All week must be filled the plan and the learning outcome!',
                                        [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK')),
                                        ]));
                          }
                        }
                      },
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: backgroundColor,
                      ),
                      label: Text(
                        'Finish',
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: titleFontSize,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  //app bar
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
              //set for preogress indicator
              weekIndex -= 1;
              //set for page view index
              selectedPageIndex -= 1;
              _tabController.animateTo(selectedPageIndex);
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
            //reset empty all fields
            showDialog(
              context: context,
              builder: (context) => buildDefaultDialog(
                context,
                'Your inputs will be lost!',
                'Are you sure to continue?',
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          //
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget buildBodyV2() {
    return SingleChildScrollView(
      child: Container(
          height: 500,
          child: Column(
            children: [
              //
              // StepProgressIndicator(
              //   totalSteps: widget.numberOfWeek,
              //   currentStep: weekIndex,
              //   selectedColor: Colors.green,
              //   unselectedColor: Colors.grey.withOpacity(0.7),
              // ),
              //tabbar view container
              Container(
                height: 500,
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: List.generate(
                      widget.numberOfWeek,
                      (index) => Container(
                            child: Container(
                                width: 400,
                                height: 460,
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    // Container(
                                    //     width: 400,
                                    //     margin:
                                    //         EdgeInsets.fromLTRB(90, 20, 90, 0),
                                    //     child: Text(
                                    //         'Study Plan - Week $weekIndex',
                                    //         style: TextStyle(
                                    //             color: textGreyColor,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 20))),
                                    Container(
                                      width: 350,
                                      height: 180,
                                      padding: EdgeInsets.only(bottom: 10),
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),

                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        boxShadow: [
                                          boxShadowStyle,
                                        ],
                                      ),
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                      child: _buildItemPlan(),
                                    ),
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 0),
                                              child: buildAddPlan(context)),
                                          buildLearningOutcome(context)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 350,
                                      height: 150,
                                      padding: EdgeInsets.only(bottom: 10),
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        boxShadow: [
                                          boxShadowStyle,
                                        ],
                                      ),
                                      child: _buildItemOutcome(),
                                      // child: Form(
                                      //   child: SingleChildScrollView(
                                      //     child: IgnorePointer(
                                      //       ignoring: false,
                                      //       ignoringSemantics: false,
                                      //       child: Column(
                                      //         children: [
                                      //           // _buildTitle(),
                                      //           Center(
                                      //             child: Container(
                                      //               margin: EdgeInsets.only(
                                      //                   left: 0),
                                      //               width: 310,
                                      //               // decoration: BoxDecoration(border: Border.all()),
                                      //               child: Text(
                                      //                 'Learning Outcome',
                                      //                 style: TextStyle(
                                      //                     fontSize: 15,
                                      //                     fontWeight:
                                      //                         FontWeight.bold,
                                      //                     color: mainColor),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //           Container(
                                      //             height: 150,
                                      //             alignment: Alignment.center,
                                      //             padding: EdgeInsets.only(
                                      //                 top: 10, bottom: 0),
                                      //             margin: EdgeInsets.symmetric(
                                      //               horizontal: 20,
                                      //             ),
                                      //             child: TextFormField(
                                      //               readOnly: isSending,
                                      //               keyboardType:
                                      //                   TextInputType.multiline,
                                      //               expands: true,
                                      //               maxLength: 500,
                                      //               maxLines: null,
                                      //               controller:
                                      //                   learningOutcomeController,
                                      //               textAlign: TextAlign.start,
                                      //               decoration: InputDecoration(
                                      //                 fillColor:
                                      //                     Color(0xffF9F2F2),
                                      //                 filled: true,
                                      //                 focusedBorder:
                                      //                     InputBorder.none,
                                      //                 enabledBorder:
                                      //                     OutlineInputBorder(
                                      //                   borderRadius:
                                      //                       BorderRadius
                                      //                           .circular(10),
                                      //                   borderSide:
                                      //                       const BorderSide(
                                      //                           color: Colors
                                      //                               .transparent,
                                      //                           width: 0.0),
                                      //                 ),
                                      //                 counter: Text(''),
                                      //                 hintText:
                                      //                     'Write the learning outcome of week $weekIndex...',
                                      //                 hintStyle: TextStyle(
                                      //                   color: Colors.grey[400],
                                      //                   fontSize: textFontSize,
                                      //                 ),
                                      //               ),
                                      //               validator:
                                      //                   RequiredValidator(
                                      //                       errorText:
                                      //                           'is required'),
                                      //             ),
                                      //           ),
                                      //           SizedBox(
                                      //             height: 20,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                )),
                          )),
                ),
              )
            ],
          )),
    );
  }

  Widget _buildItemPlan() {
    return Container(
      child: ListView.builder(
          itemCount: listPlan.length,
          itemBuilder: (context, index) => Column(
                children: [
                  listPlan.length > 0
                      ? listPlan[index].period == 'Week $weekIndex'
                          ? Column(
                              children: [
                                buildWeekPlanItem(
                                    listPlan[index].schedule,
                                    'Plan ' + '${index + 1}',
                                    Icons.check_outlined,
                                    Icons.more_vert,
                                    index),
                                buildDivider(),
                              ],
                            )
                          : Container()
                      : Container(),
                  // buildDivider(),
                ],
              )),
    );
  }

  Widget _buildItemOutcome() {
    return Container(
      child: ListView.builder(
          itemCount: listOutcome.length,
          itemBuilder: (context, index) => Column(
                children: [
                  listOutcome.length > 0
                      ? listOutcome[index].period == 'Week $weekIndex'
                          ? Column(
                              children: [
                                buildWeekOutcomeItem(
                                    listOutcome[index].learningOutcome,
                                    'Outcome ' + '${index + 1}',
                                    Icons.check_outlined,
                                    Icons.more_vert,
                                    index),
                                buildDivider(),
                              ],
                            )
                          : Container()
                      : Container(),
                  // buildDivider(),
                ],
              )),
    );
  }

  ListTile buildWeekOutcomeItem(String content, String title, IconData icon,
      IconData editIcon, int index) {
    return ListTile(
      leading: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: 23,
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
        style: TextStyle(
            fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Content: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 125,
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 14,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
                      editLearningOutcomeController.text =
                          listOutcome[index].learningOutcome;
                      _showEditInputOutcomeDialog(context, index);
                    });
                    // Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Remove'),
                  onPressed: () {
                    setState(() {
                      listOutcome.remove(listOutcome[index]);
                    });
                  },
                ),
              )
            ];
          },
        ),
      ),
    );
  }

  _showEditInputOutcomeDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              elevation: 1.0,
              insetAnimationCurve: Curves.ease,
              child: _editOutcomeDialogWidget(index),
            ));
  }

  Widget _editOutcomeDialogWidget(int index) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: false,
          ignoringSemantics: false,
          child: Column(
            children: [
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(left: 0),
                width: 230,
                // decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'Content',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
              ),
              Container(
                height: 150,
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
                  controller: editLearningOutcomeController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                    ),
                    counter: Text(''),
                    hintText: 'Write the learning outcome of week...',
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
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        listOutcome[index].learningOutcome =
                            editLearningOutcomeController.text;
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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
        width: 23,
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
        style: TextStyle(
            fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Content: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 125,
                      child: Text(
                        content,
                        style: TextStyle(
                          fontSize: 14,
                          color: textGreyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
                      editPlanController.text = listPlan[index].schedule;
                      _showEditInputPlanDialog(context, index);
                    });
                    // Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: Text('Remove'),
                  onPressed: () {
                    setState(() {
                      listPlan.remove(listPlan[index]);
                    });
                  },
                ),
              )
            ];
          },
        ),
      ),
    );
  }

  _showEditInputPlanDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              elevation: 1.0,
              insetAnimationCurve: Curves.ease,
              child: _editPlanDialogWidget(index),
            ));
  }

  Widget _editPlanDialogWidget(int index) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: false,
          ignoringSemantics: false,
          child: Column(
            children: [
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(left: 0),
                width: 230,
                // decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'Content',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
              ),
              Container(
                height: 150,
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
                  controller: editPlanController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
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
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        listPlan[index].schedule = editPlanController.text;
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
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
      ),
    );
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

  _showInputLearningOutcome(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: backgroundColor,
              elevation: 1.0,
              insetAnimationCurve: Curves.ease,
              child: _dialogOutcomeWidget(),
            ));
  }

  Widget _dialogOutcomeWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: isSending,
          ignoringSemantics: true,
          child: Column(
            children: [
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(left: 0),
                width: 230,
                // decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'Outcome',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
              ),
              Container(
                height: 150,
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
                  controller: learningOutcomeController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
                    ),
                    counter: Text(''),
                    hintText: 'Write the learning outcome of week...',
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
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        CourseDetail newCourseDetail = CourseDetail.weekOutcome(
                            'Week $weekIndex', learningOutcomeController.text);
                        listOutcome.add(newCourseDetail);
                        learningOutcomeController.text = '';
                        Navigator.pop(context);
                      }
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
      ),
    );
  }

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

  Widget _dialogWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: isSending,
          ignoringSemantics: true,
          child: Column(
            children: [
              _buildTitle(),
              Container(
                margin: EdgeInsets.only(left: 0),
                width: 230,
                // decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'Content',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                ),
              ),
              Container(
                height: 150,
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
                  controller: planController,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    fillColor: Color(0xffF9F2F2),
                    filled: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.0),
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
              // Container(
              //   margin: EdgeInsets.only(left: 0),
              //   width: 230,
              //   // decoration: BoxDecoration(border: Border.all()),
              //   child: Text(
              //     'Learning outcome',
              //     style: TextStyle(
              //         fontSize: 15,
              //         fontWeight: FontWeight.bold,
              //         color: mainColor),
              //   ),
              // ),
              // Container(
              //   height: 150,
              //   alignment: Alignment.center,
              //   padding: EdgeInsets.only(top: 10, bottom: 0),
              //   margin: EdgeInsets.symmetric(
              //     horizontal: 20,
              //   ),
              //   child: TextFormField(
              //     readOnly: isSending,
              //     keyboardType: TextInputType.multiline,
              //     expands: true,
              //     maxLength: 500,
              //     maxLines: null,
              //     controller: learningOutcomeController,
              //     textAlign: TextAlign.start,
              //     decoration: InputDecoration(
              //       fillColor: Color(0xffF9F2F2),
              //       filled: true,
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //         borderSide: const BorderSide(
              //             color: Colors.transparent, width: 0.0),
              //       ),
              //       counter: Text(''),
              //       hintText: 'Write the learning outcome...',
              //       hintStyle: TextStyle(
              //         color: Colors.grey[400],
              //         fontSize: textFontSize,
              //       ),
              //     ),
              //     validator: RequiredValidator(errorText: 'is required'),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        CourseDetail newCourseDetail = CourseDetail.weekPlan(
                            'Week $weekIndex', planController.text);
                        listPlan.add(newCourseDetail);
                        planController.text = '';

                        Navigator.pop(context);
                      }
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
      ),
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

  FloatingActionButton buildLearningOutcome(BuildContext context) =>
      FloatingActionButton.extended(
          onPressed: () {
            _showInputLearningOutcome(context);
          },
          label: Text(
            'Add Outcome',
            style: TextStyle(
                fontSize: titleFontSize,
                color: mainColor,
                fontWeight: FontWeight.bold),
          ),
          isExtended: true,
          backgroundColor: Colors.white);
}
