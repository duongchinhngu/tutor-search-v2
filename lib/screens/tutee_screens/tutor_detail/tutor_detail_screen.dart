import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/enrollment_cubit.dart';
import 'package:tutor_search_system/cubits/feedback_cubit.dart';
import 'package:tutor_search_system/cubits/tutor_cubit.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/models/extended_models/extended_tutor.dart';
import 'package:tutor_search_system/models/feedback.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:tutor_search_system/repositories/enrollment_repository.dart';
import 'package:tutor_search_system/repositories/feedback_repository.dart';
import 'package:tutor_search_system/repositories/tutor_repository.dart';
import 'package:tutor_search_system/screens/common_ui/common_buttons.dart';
import 'package:tutor_search_system/screens/common_ui/full_screen_image.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/home_course_detail.dart';
import 'package:tutor_search_system/screens/tutee_screens/tutee_map/tutee_search_map.dart';
import 'package:tutor_search_system/screens/tutor_screens/feeback/feedback_card.dart';
import 'package:tutor_search_system/states/enrollment_state.dart';
import 'package:tutor_search_system/states/feedback_state.dart';
import 'package:tutor_search_system/states/tutor_state.dart';
import 'package:url_launcher/url_launcher.dart';

FeedbackRepository feedbackRepository;

class TutorDetails extends StatelessWidget {
  final int tutorId;
  final Course course;
  final bool hasFollowButton;
  const TutorDetails(
      {Key key,
      @required this.tutorId,
      @required this.course,
      @required this.hasFollowButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorCubit(TutorRepository()),
      child:
          // ignore: missing_return
          BlocBuilder<TutorCubit, TutorState>(builder: (context, state) {
        //call category cubit and get all course
        final tutorCubit = context.watch<TutorCubit>();
        tutorCubit.getTutorByTutorId(tutorId);
        //render proper UI for each Course state
        if (state is TutorLoadingState) {
          return buildLoadingIndicator();
        } else if (state is ExtendedTutorLoadedState) {
          //
          print('this is certi' + state.tutor.certificationUrls.toString());
          //
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              leading: buildDefaultBackButton(context),
            ),
            body: Container(
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                        color: mainColor,
                      ),
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 60, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(
                                state.tutor.avatarImageLink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(140, 60, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            child: Container(
                              width: 200,
                              height: 40,
                              child: Text(
                                state.tutor.fullname,
                                style: TextStyle(
                                    color: textWhiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/starsmall.png'),
                                Image.asset('assets/images/starsmall.png'),
                                Image.asset('assets/images/starsmall.png'),
                                Image.asset('assets/images/starsmall.png'),
                                Image.asset('assets/images/starsmall.png'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
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
                              width: 210,
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "12",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "Courses",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "125",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "Reviews",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "176",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                            color: textGreyColor,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //tutor information
                    TutorInformation(
                      tutor: state.tutor,
                      course: course,
                    ),
                  ],
                ),
              ),
            ),
            //follow button
            floatingActionButton: Visibility(
                visible: hasFollowButton,
                child: buildFollowButton(context, course)),
          );
        } else if (state is TutorLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }
}

class TutorInformation extends StatelessWidget {
  final ExtendedTutor tutor;
  final Course course;
  const TutorInformation({
    Key key,
    @required this.tutor,
    @required this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnrollmentCubit(EnrollmentRepository()),
      child: BlocBuilder<EnrollmentCubit, EnrollmentState>(
        builder: (context, state) {
          //
          final enrollmentCubit = context.watch<EnrollmentCubit>();
          enrollmentCubit.getEnrollmentByCourseIdTuteeId(
              course.id, authorizedTutee.id);
          //
          bool isCensoredInfo = true;
          if (state is EnrollmentLoadedState) {
            if (state.enrollment != null &&
                state.enrollment.status == EnrollmentConstants.ACTIVE_STATUS) {
              isCensoredInfo = false;
            }
          }
          //
          return Padding(
            padding: const EdgeInsets.only(top: 230),
            child: Container(
              decoration: BoxDecoration(),
              child: ListView(
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  tutor.description,
                                  style: TextStyle(
                                    color: textGreyColor,
                                    fontSize: 11,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 30),
                                  //         child: Image.asset(
                                  //             'assets/images/gender.png'),
                                  //       ),
                                  //       Text(tutor.gender)
                                  //     ],
                                  //   ),
                                  // ),

                                  buildCourseInformationListTile(
                                      tutor.gender, 'Gender', Icons.gesture),
                                  buildDivider(),
                                  buildCourseInformationListTile(
                                      tutor.birthday, 'Birthday', Icons.cake),
                                  // buildDivider(),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 30),
                                  //         child: Image.asset(
                                  //             'assets/images/email.png'),
                                  //       ),
                                  //       Stack(
                                  //         children: [
                                  //           //email
                                  //           GestureDetector(
                                  //             onTap: () {
                                  //               //ui to launch to email
                                  //               final Uri _emailLaunchUri = Uri(
                                  //                   scheme: 'mailto',
                                  //                   path: tutor.email,
                                  //                   queryParameters: {
                                  //                     'subject': authorizedTutee
                                  //                             .fullname +
                                  //                         ' ask to join you course!',
                                  //                     'body':
                                  //                         'I would like to contact you for your course! ...'
                                  //                   });
                                  //               //launch
                                  //               launch(_emailLaunchUri
                                  //                   .toString()
                                  //                   .replaceAll('+', ' '));
                                  //             },
                                  //             child: Text(
                                  //               tutor.email,
                                  //               style: TextStyle(
                                  //                   color: Colors.blue,
                                  //                   fontSize: textFontSize,
                                  //                   decoration: TextDecoration
                                  //                       .underline),
                                  //             ),
                                  //           ),
                                  //           //
                                  //           Visibility(
                                  //             visible: isCensoredInfo,
                                  //             child: Positioned.fill(
                                  //               child: ClipRect(
                                  //                 child: BackdropFilter(
                                  //                   filter: ImageFilter.blur(
                                  //                     sigmaY: 5,
                                  //                     sigmaX: 5,
                                  //                   ),
                                  //                   child: Container(
                                  //                     color: Colors.black
                                  //                         .withOpacity(0),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  buildDivider(),
                                  buildCourseInformationListTile(
                                      tutor.educationLevel,
                                      'Education Level',
                                      Icons.cast_for_education_outlined),

                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          //ui to launch to email
                                          final Uri _emailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: tutor.email,
                                              queryParameters: {
                                                'subject': authorizedTutee
                                                        .fullname +
                                                    ' ask to join you course!',
                                                'body':
                                                    'I would like to contact you for your course! ...'
                                              });
                                          //launch
                                          launch(_emailLaunchUri
                                              .toString()
                                              .replaceAll('+', ' '));
                                        },
                                        child:
                                            buildCourseInformationListTileBlurInfo(
                                                tutor.email,
                                                'Email',
                                                Icons.email),
                                      ),
                                      // Visibility(
                                      //   visible: isCensoredInfo,
                                      //   child: Positioned.fill(
                                      //     child: ClipRect(
                                      //       child: BackdropFilter(
                                      //         filter: ImageFilter.blur(
                                      //           sigmaY: 5,
                                      //           sigmaX: 5,
                                      //         ),
                                      //         child: Container(
                                      //           color:
                                      //               Colors.black.withOpacity(0),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      buildDivider(),
                                    ],
                                  ),

                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          launch('tel:${tutor.phone}');
                                        },
                                        child:
                                            buildCourseInformationListTileBlurInfo(
                                                tutor.phone,
                                                'Phone',
                                                Icons.phone_android),
                                      ),
                                      buildDivider(),
                                    ],
                                  ),

                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TuteeSearchGoogleMap(
                                                        tutoraddress:
                                                            tutor.address,
                                                        tuteeaddress:
                                                            authorizedTutee
                                                                .address,
                                                      )));
                                        },
                                        child:
                                            buildCourseInformationListTileBlurInfo(
                                          tutor.address,
                                          'Address',
                                          Icons.home_outlined,
                                        ),
                                      ),
                                      buildDivider(),
                                    ],
                                  ),

                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 30),
                                  //         child: Image.asset(
                                  //             'assets/images/phone.png'),
                                  //       ),
                                  //       Stack(
                                  //         children: [
                                  //           //phone number
                                  //           GestureDetector(
                                  //             child: Text(
                                  //               tutor.phone,
                                  //               style: TextStyle(
                                  //                 color: Colors.green,
                                  //                 decoration:
                                  //                     TextDecoration.underline,
                                  //               ),
                                  //             ),
                                  //             onTap: () {
                                  //               launch('tel:${tutor.phone}');
                                  //             },
                                  //           ),
                                  //           //
                                  //           Visibility(
                                  //             visible: isCensoredInfo,
                                  //             child: Positioned.fill(
                                  //               child: ClipRect(
                                  //                 child: BackdropFilter(
                                  //                   filter: ImageFilter.blur(
                                  //                     sigmaY: 5,
                                  //                     sigmaX: 5,
                                  //                   ),
                                  //                   child: Container(
                                  //                     color: Colors.black
                                  //                         .withOpacity(0),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 30),
                                  //         child: Image.asset(
                                  //             'assets/images/pinlocation.png'),
                                  //       ),
                                  //       Stack(
                                  //         children: [
                                  //           //phone number
                                  //           Container(
                                  //             margin: const EdgeInsets.fromLTRB(
                                  //                 0, 0, 10, 0),
                                  //             width: 260,
                                  //             child: GestureDetector(
                                  //               child: Text(
                                  //                 tutor.address,
                                  //                 style: TextStyle(
                                  //                   color: Colors.red,
                                  //                   decoration: TextDecoration
                                  //                       .underline,
                                  //                 ),
                                  //               ),
                                  //               onTap: () {
                                  //                 Navigator.of(context).push(
                                  //                     MaterialPageRoute(
                                  //                         builder: (context) =>
                                  //                             TuteeSearchGoogleMap(
                                  //                               tutoraddress:
                                  //                                   tutor
                                  //                                       .address,
                                  //                               tuteeaddress:
                                  //                                   authorizedTutee
                                  //                                       .address,
                                  //                             )));
                                  //               },
                                  //             ),
                                  //           ),
                                  //           //
                                  //           Visibility(
                                  //             visible: isCensoredInfo,
                                  //             child: Positioned.fill(
                                  //               child: ClipRect(
                                  //                 child: BackdropFilter(
                                  //                   filter: ImageFilter.blur(
                                  //                     sigmaY: 5,
                                  //                     sigmaX: 5,
                                  //                   ),
                                  //                   child: Container(
                                  //                     color: Colors.black
                                  //                         .withOpacity(0),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding:
                                  //       const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(right: 30),
                                  //         child: Image.asset(
                                  //             'assets/images/major.png'),
                                  //       ),
                                  //       Text(tutor.educationLevel)
                                  //     ],
                                  //   ),
                                  // ),
                                  buildDivider(),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Text(
                                            'Certification Image(s)',
                                            style: TextStyle(
                                              color: mainColor,
                                              fontSize: titleFontSize,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 260,
                                          alignment: Alignment.centerLeft,
                                          child: Wrap(
                                            runAlignment:
                                                WrapAlignment.spaceBetween,
                                            runSpacing: 10,
                                            spacing: 10,
                                            children: List.generate(
                                                tutor.certificationUrls.length,
                                                (index) {
                                              //view photo in fullscreen
                                              return InkWell(
                                                onTap: () {
                                                  //
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FullScreenImage(
                                                        imageWidget:
                                                            Image.network(
                                                          tutor.certificationUrls[
                                                              index],
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: 125,
                                                  width: 125,
                                                  child: Image.network(
                                                    tutor.certificationUrls[
                                                        index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 10, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Text(
                                            'Feedback from Tutee(s)',
                                            style: TextStyle(
                                              color: mainColor,
                                              fontSize: titleFontSize,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            child: GetFeedback(
                                          tutorid: tutor.id,
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class GetFeedback extends StatelessWidget {
  final int tutorid;

  const GetFeedback({Key key, this.tutorid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FeedbackCubit(FeedbackRepository()),
        child: BlocBuilder<FeedbackCubit, FeedbackState>(
            builder: (context, state) {
          final cubit = context.watch<FeedbackCubit>();
          // cubit.getFeedbackByTuteeId(authorizedTutor.id);
          cubit.getFeedbackByTutorId(tutorid);
          //
          if (state is FeedbackErrorState) {
            // return ErrorScreen();
            return Text(state.errorMessage);
          } else if (state is InitialFeedbackState) {
            return buildLoadingIndicator();
          } else if (state is FeedbackNoDataState) {
            return NoDataScreen();
          } else if (state is FeedbackListLoadedState) {
            // return ListView.builder(
            //     itemCount: state.feedbacks.length,
            //     itemBuilder: (context, index) => CardFeedback(
            //           feedbacks: state.feedbacks[index],
            //         ));
            return _buildListFeedback(state);
          }
        }));
  }
}

Widget _buildListFeedback(FeedbackListLoadedState state) {
  return Container(
      child: Column(
    children: List.generate(
      state.feedbacks.length,
      (index) => ListFeedback(
        feedbacks: state.feedbacks[index],
      ),
    ),
  ));

  // return Container(
  //   child: GridView.builder(
  //     gridDelegate: SilverGridDelegte,

  //     itemCount: state.feedbacks.length,
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) => ListFeedback(
  //       feedbacks: state.feedbacks[index],
  //     ),
  //   ),
  // );
}

class ListFeedback extends StatefulWidget {
  final Feedbacks feedbacks;

  const ListFeedback({Key key, this.feedbacks}) : super(key: key);
  @override
  _ListFeedbackState createState() => _ListFeedbackState();
}

class _ListFeedbackState extends State<ListFeedback> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //avatar
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.feedbacks.tuteeAvatarUrl),
                  radius: 30,
                ),
              ),
              //
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name tutee
                      Text(
                        widget.feedbacks.tuteeName,
                        style: headerStyle,
                      ),
                      ////rate star
                      Container(
                        child: RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: widget.feedbacks.rate,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 20,
                          onRatingUpdate: (double value) {},
                        ),
                      ),
                      //content
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.feedbacks.comment),
                      )
                    ],
                  ),
                ),
              ),
              //createdDate
              Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      widget.feedbacks.createdDate.substring(0, 10),
                      style: textStyle,
                    )),
              )
            ],
          ),
          //
          Divider(
            indent: 20,
            endIndent: 30,
          )
        ],
      ),
    );
  }
}

class CardFeedback extends StatelessWidget {
  final Feedbacks feedbacks;

  const CardFeedback({Key key, this.feedbacks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        //
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //avatar
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundImage: NetworkImage(feedbacks.tuteeAvatarUrl),
                radius: 30,
              ),
            ),
            //
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name tutee
                    Text(
                      feedbacks.tuteeName,
                      style: headerStyle,
                    ),
                    ////rate star
                    Container(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: feedbacks.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 20,
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    //content
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(feedbacks.comment),
                    )
                  ],
                ),
              ),
            ),
            //createdDate
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    feedbacks.createdDate.substring(0, 10),
                    style: textStyle,
                  )),
            )
          ],
        ),
        //
        Divider(
          indent: 20,
          endIndent: 30,
        )
      ],
    );
  }
}
