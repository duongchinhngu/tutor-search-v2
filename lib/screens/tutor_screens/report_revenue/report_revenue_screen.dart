import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_strip/month_picker_strip.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/enrollment_cubit.dart';
import 'package:tutor_search_system/models/enrollment_course.dart';
import 'package:tutor_search_system/repositories/commission_repository.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/courseenrollment_state.dart';
import 'package:tutor_search_system/states/enrollment_state.dart';

double commissionRate;
List<CourseEnrollment> listEnrollment = new List();
double currentRevenue = 0;

class ReportRevenueScreen extends StatefulWidget {
  @override
  _ReportRevenue createState() => _ReportRevenue();
}

class _ReportRevenue extends State<ReportRevenueScreen> {
  DateTime currentDate;
  double current = 0;

  void initState() {
    //
    currentDate = DateTime.now();
    //
    registerOnFirebase();
    getMessage(context);
    super.initState();
    //
    CommissionRepository()
        .fetchCommissionByCommissionId(http.Client(), 1)
        .then((value) => {
              if (value != null)
                {
                  commissionRate = value.rate * 100,
                  print(commissionRate),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnrollmentCubit(EnrollmentRepository()),
      child: BlocBuilder<EnrollmentCubit, EnrollmentState>(
          builder: (context, state) {
        //
        final courseenroll = context.watch<EnrollmentCubit>();
        courseenroll.getEnrollmentOfMonthByTutorIdDate(
            authorizedTutor.id, currentDate.toString());

        //
        if (state is CourseEnrollmentLoadingState) {
          return buildLoadingIndicator();
        } else if (state is CourseEnrollmentListNoDataState) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: buildRevenueDetailAppbar(context),
            body: Column(
              children: <Widget>[
                //month stripe
                new Divider(
                  height: 1.0,
                ),
                new MonthStrip(
                  format: 'MMM yyyy',
                  from: new DateTime(
                      int.parse(authorizedTutor.createdDate.substring(0, 4)),
                      int.parse(authorizedTutor.createdDate.substring(6, 7))),
                  to: new DateTime.now(),
                  initialMonth: currentDate,
                  height: 48.0,
                  viewportFraction: 0.25,
                  onMonthChanged: (v) {
                    setState(() {
                      currentDate = v;
                    });
                  },
                ),
                new Divider(
                  height: 1.0,
                ),
                //month stripe
                //
                Column(
                  children: [
                    //
                    Center(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Text(
                            'Detail Total Revenue',
                            style: TextStyle(
                              color: textGreyColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                    ),
                    //
                    Container(
                      width: 320,
                      height: 170,
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
                      child: Column(
                        children: [
                          //
                          buildRevenueInformationListTile(
                              '0', 'Quantity of Enrollments', Icons.person_add),
                          buildDivider(),
                          buildRevenueInformationListTile(
                              '$current \$', 'Current revenue', Icons.money),
                          // _calTotalProfit(state),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text(
                        'Detail revenue of Enrollment (' + '0' + ')',
                        style: TextStyle(
                          color: textGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text('No Enrollment')
                  ],
                )
                //
              ],
            ),
          );
        } else if (state is CourseEnrollmentLoadFailedState) {
          // return ErrorScreen();
          return Text(state.errorMessage);
        } else if (state is CourseEnrollmentListLoadedState) {
          print('this is tutor createdDate: ' + authorizedTutor.createdDate + authorizedTutor.confirmedDate);
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildRevenueDetailAppbar(context),
              body: ListView(children: [
                Column(
                  children: <Widget>[
                    //month stripe
                    new Divider(
                      height: 1.0,
                    ),
                    new MonthStrip(
                      format: 'MMM yyyy',
                      from: new DateTime(
                          int.parse(
                              authorizedTutor.createdDate.substring(0, 4)),
                          int.parse(
                              authorizedTutor.createdDate.substring(6, 7))),
                      to: new DateTime.now(),
                      initialMonth: currentDate,
                      height: 48.0,
                      viewportFraction: 0.25,
                      onMonthChanged: (v) {
                        setState(() {
                          currentDate = v;
                        });
                      },
                    ),
                    new Divider(
                      height: 1.0,
                    ),
                    //month stripe
                    //
                    Column(
                      children: [
                        //
                        Center(
                          child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Text(
                                'Detail Total Revenue',
                                style: TextStyle(
                                  color: textGreyColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )),
                        ),
                        //
                        Container(
                          width: 320,
                          height: 170,
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
                          child: Column(
                            children: [
                              //
                              buildRevenueInformationListTile(
                                  state.courseEnrollment.length.toString(),
                                  'Quantity of Enrollments',
                                  Icons.person_add),
                              buildDivider(),
                              //
                              _calTotalProfit(state),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Text(
                            'Detail revenue of Enrollment (' +
                                state.courseEnrollment.length.toString() +
                                ')',
                            style: TextStyle(
                              color: textGreyColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          width: 320,
                          height: 400,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _buildListCourseEnrollment(state),
                        ),
                      ],
                    )
                    //
                  ],
                ),
              ]));
        } else if (state is CourseEnrollmentLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }
}

Widget _calTotalProfit(CourseEnrollmentListLoadedState state) {
  double profit = 0;
  for (int i = 0; i < state.courseEnrollment.length; i++) {
    profit = profit +
        state.courseEnrollment[i].studyFee -
        state.courseEnrollment[i].studyFee * (commissionRate / 100);
  }
  return buildRevenueInformationListTile(
      '$profit \$', 'Current revenue', Icons.money);
}

Widget _buildListCourseEnrollment(CourseEnrollmentListLoadedState state) {
  return ListView.builder(
    itemCount: state.courseEnrollment.length,
    itemBuilder: (context, index) => CardCourseEnrollment(
      course_enroll: state.courseEnrollment[index],
    ),
  );
}

class CardCourseEnrollment extends StatefulWidget {
  final CourseEnrollment course_enroll;

  const CardCourseEnrollment({Key key, this.course_enroll}) : super(key: key);
  @override
  _CardCourseEnrollmentState createState() => _CardCourseEnrollmentState();
}

class _CardCourseEnrollmentState extends State<CardCourseEnrollment> {
  double profit;
  void initState() {
    super.initState();
    profit = widget.course_enroll.studyFee -
        widget.course_enroll.studyFee * (commissionRate / 100);
    currentRevenue = currentRevenue + profit;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
      padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
      width: 60,
      height: 210,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(widget.course_enroll.courseName,
                style: TextStyle(
                    fontSize: 18,
                    color: textGreyColor,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Join fee: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textGreyColor,
                    ),
                  ),
                ),
                Text(
                  widget.course_enroll.studyFee.toString() + ' \$',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Text(
                    'Tutee: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textGreyColor,
                    ),
                  ),
                ),
                Text(
                  widget.course_enroll.tuteeName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    'Charge by System: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textGreyColor,
                    ),
                  ),
                ),
                Text(
                  commissionRate.toStringAsFixed(0) + '%',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    'Profit: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textGreyColor,
                    ),
                  ),
                ),
                Text(
                  profit.toString() + ' \$',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}

ListTile buildRevenueInformationListTile(
    String content, String title, IconData icon) {
  return ListTile(
    leading: Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5,
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
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey[500],
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Text(
      content,
      style: TextStyle(
        fontSize: titleFontSize,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

PreferredSize buildRevenueDetailAppbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(40),
    child: AppBar(
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/appbar.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    ),
  );
}
