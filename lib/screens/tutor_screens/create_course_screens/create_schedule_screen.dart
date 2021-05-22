import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';

List<String> learningPlan = [];
TextEditingController commentController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
List<String> list = [];

class CreateCourseSchedule extends StatefulWidget {
  @override
  _CreateCourseScheduleState createState() => _CreateCourseScheduleState();
}

class _CreateCourseScheduleState extends State<CreateCourseSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text('Create Schedule'),
        ),
        body: Container(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            width: 400,
            height: double.infinity,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Schedule - Week 1',
                      style: TextStyle(
                        color: textGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
                Container(
                  width: 400,
                  height: 400,
                  child: _buildItemPlan(),
                ),
                // buildDivider(),
                buildAddPlan(context),
              ],
            ),
          ),
        ));
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
}

// class InputPlan extends StatefulWidget {
//   @override
//   _InputPlanState createState() => _InputPlanState();
// }

// class _InputPlanState extends State<InputPlan> {

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildTitle(),
//             Container(
//               height: 200,
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(top: 10, bottom: 0),
//               margin: EdgeInsets.symmetric(
//                 horizontal: 20,
//               ),
//               child: TextFormField(
//                 readOnly: isSending,
//                 keyboardType: TextInputType.multiline,
//                 expands: true,
//                 maxLength: 500,
//                 maxLines: null,
//                 controller: commentController,
//                 textAlign: TextAlign.start,
//                 decoration: InputDecoration(
//                   fillColor: Color(0xffF9F2F2),
//                   filled: true,
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide:
//                         const BorderSide(color: Colors.transparent, width: 0.0),
//                   ),
//                   counter: Text(''),
//                   hintText: 'Write the plan/content of learning...',
//                   hintStyle: TextStyle(
//                     color: Colors.grey[400],
//                     fontSize: textFontSize,
//                   ),
//                 ),
//                 validator: RequiredValidator(errorText: 'is required'),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: GestureDetector(
//                 onTap: () async {
//                   setState(() {
//                     list.add(commentController.text);
//                     learningPlan = list;
//                     Navigator.pop(context);
//                   });
//                 },
//                 child: Container(
//                   width: 94,
//                   height: 38,
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.only(right: 20, bottom: 20),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: mainColor,
//                   ),
//                   child: Text(
//                     'Save',
//                     style: TextStyle(
//                       fontSize: titleFontSize,
//                       color: textWhiteColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

Widget _buildItemPlan() {
  return ListView.builder(
      itemCount: learningPlan.length,
      itemBuilder: (context, index) => Column(
            children: [
              buildWeekPlanItem(
                  learningPlan[index], 'Content' + '$index', Icons.grade),
              buildDivider(),
            ],
          ));
}

ListTile buildWeekPlanItem(String content, String title, IconData icon) {
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
  );
}