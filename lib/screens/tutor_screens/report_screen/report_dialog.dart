import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/functions/common_functions.dart';
import 'package:tutor_search_system/commons/functions/firebase_functions.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/report_type_cubit.dart';
import 'package:tutor_search_system/cubits/report_type_cubit.dart';
import 'package:tutor_search_system/models/report_type.dart';
import 'package:tutor_search_system/models/tutor_report.dart';
import 'package:tutor_search_system/repositories/report_type_repository.dart';
import 'package:tutor_search_system/repositories/tutor_report_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_dialogs.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/states/report_type_state.dart';

//sending status
bool isSending = false;
//
Future showReportDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: backgroundColor,
      elevation: 1.0,
      insetAnimationCurve: Curves.ease,
      child: TutorReportDialog(),
    ),
  );
}

class TutorReportDialog extends StatefulWidget {
  @override
  _TutorReportDialogState createState() => _TutorReportDialogState();
}

class _TutorReportDialogState extends State<TutorReportDialog> {
  //
  List<File> reportPhoto = [];
  //
  ReportType selectedReportType;
  //  'Select report type';
  //
  @override
  void initState() {
    super.initState();
    isSending = false;
  }

  //text controller for comment
  TextEditingController commentController = TextEditingController();
  //
  //validator for all input field
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: IgnorePointer(
          ignoring: isSending,
          ignoringSemantics: true,
          child: Container(
            // height: 460,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //title and icon label
                _buildReportTitle(),
                //report type
                ListTile(
                  title: InkWell(
                    onTap: () {
                      //select report type bottom sheet
                      reportTypeSelector(context);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: textGreyColor.withOpacity(.5)),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(
                              selectedReportType != null
                                  ? selectedReportType.name
                                  : 'Select report type',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: titleFontSize - 1,
                                color: textGreyColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: mainColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //comment
                Container(
                  height: 280,
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
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0.0),
                      ),
                      counter: Text(''),
                      hintText: 'Tell us your problems..',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: textFontSize,
                      ),
                    ),
                    validator: RequiredValidator(errorText: 'is required'),
                  ),
                ),
                //
                InkWell(
                  onTap: () async {
                    //select photo from galary
                    var img = await getImageFromGallery();
                    //
                    if (img != null) {
                      setState(() {
                        reportPhoto.add(img);
                      });
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        bottom: 10,
                      ),
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      width: 115,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        color: backgroundColor,
                        border: Border.all(width: 1, color: mainColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //
                          Icon(
                            Icons.add,
                            color: mainColor,
                          ),
                          //
                          Text(
                            'Add photo',
                            style: TextStyle(
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                Container(
                  width: 260,
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceBetween,
                    runSpacing: 10,
                    spacing: 10,
                    children: List.generate(
                      reportPhoto.length,
                      (index) {
                        //view photo in fullscreen
                        return Container(
                          height: 125,
                          width: 125,
                          child: PopupMenuButton(
                            child: Image.file(
                              reportPhoto[index],
                            ),
                            itemBuilder: (context) {
                              return <PopupMenuItem>[
                                PopupMenuItem(
                                  child: TextButton(
                                    child: Text('Detail'),
                                    onPressed: () {
                                      //
                                      Navigator.pop(context);
                                      //
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                              imageWidget: Image.file(
                                                reportPhoto[index],
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: TextButton(
                                    child: Text(
                                      'Remove',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.red.withOpacity(.8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        reportPhoto.removeAt(index);
                                      });
                                    },
                                  ),
                                )
                              ];
                            },
                          ),
                        );
                        // }
                      },
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 20,
                ),
                // send button
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        if (selectedReportType == null) {
                          //show alert dialog
                          showDialog(
                              context: context,
                              builder: (context) => buildDefaultDialog(
                                      context,
                                      "Invalid!",
                                      "Report type must be selected.", [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ]));
                        } else {
                          // // to lock screen
                          setState(() {
                            isSending = !isSending;
                            //
                          });
                          //
                          List<String> photoUrls = [];
                          //post report photo on firebase storage
                          for (var img in reportPhoto) {
                            var url = await uploadFileOnFirebaseStorage(img);
                            photoUrls.add(url);
                          }
                          //send report
                          final TutorReport tutorReport =
                              TutorReport.constructor(
                                  0,
                                  commentController.text,
                                  selectedReportType.id,
                                  authorizedTutor.id,
                                  photoUrls,
                                  StatusConstants.PENDING_STATUS);
                          //
                          await TutorReportRepository()
                              .postTutorReport(tutorReport);
                          //
                          showCompletedDialog(context);
                          //
                          Navigator.pop(context);
                        }
                      }
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
                        isSending ? 'Sending..' : 'Send',
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
      ),
    );
  }

  //load all classes by api
  Future<dynamic> reportTypeSelector(BuildContext context) =>
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: BlocProvider(
                create: (context) => ReportTypeCubit(ReportTypeRepository()),
                child: BlocBuilder<ReportTypeCubit, ReportTypeState>(
                  builder: (context, state) {
                    //
                    final reportTypeCubit = context.watch<ReportTypeCubit>();
                    reportTypeCubit.getReportType(authorizedTutor.roleId);
                    //
                    if (state is ReportTypeLoadingState) {
                      return buildLoadingIndicator();
                    } else if (state is ReportTypeLoadFailedState) {
                      return ErrorScreen();
                    } else if (state is ReportTypeNoDataState) {
                      return NoDataScreen();
                    } else if (state is ReportTypeListLoadedState) {
                      return Container(
                          child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: state.reportTypes.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: Visibility(
                                visible: selectedReportType?.id ==
                                    state.reportTypes[index].id,
                                child: Icon(
                                  Icons.check,
                                  color: mainColor,
                                  size: 15,
                                ),
                              ),
                              title: Text(
                                state.reportTypes[index].name,
                                style: TextStyle(
                                  color: selectedReportType?.id ==
                                          state.reportTypes[index].id
                                      ? mainColor
                                      : textGreyColor,
                                  fontSize: titleFontSize,
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  selectedReportType = state.reportTypes[index];
                                });
                                Navigator.pop(context);
                              });
                        },
                      ));
                    }
                  },
                ),
              ),
            );
          });
}

Container _buildReportTitle() {
  return Container(
    alignment: Alignment.centerLeft,
    width: double.infinity,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //feedback icon
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.flag,
            color: Colors.amber,
            size: 40,
          ),
        ),
        //label
        Text(
          'Report your problems',
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

Future<dynamic> showCompletedDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //complete icon
            Container(
              height: 100,
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.check_circle_outlined,
                size: 80,
                color: Colors.greenAccent[700],
              ),
            ),
            //thank you title
            Container(
              child: Text(
                'Your report will be verified soon!',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: textGreyColor,
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //explanation text field
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 30,
              ),
              child: Text(
                'Your problem is on processing by manager and admin.\n We will notify you soon. Please wait',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.grey,
                ),
              ),
            ),
            //
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 94,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColor,
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    color: textWhiteColor,
                    fontWeight: FontWeight.bold,
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
