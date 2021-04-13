import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/cubits/feedback_cubit.dart';
import 'package:tutor_search_system/repositories/feedback_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/screens/common_ui/no_data_screen.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutor_screens/feeback/feedback_card.dart';
import 'package:tutor_search_system/states/feedback_state.dart';

class TutorFeedbackScreen extends StatefulWidget {
  @override
  _TutorFeedbackScreenState createState() => _TutorFeedbackScreenState();
}

class _TutorFeedbackScreenState extends State<TutorFeedbackScreen> {
  @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) => FeedbackCubit(FeedbackRepository()),
        child: BlocBuilder<FeedbackCubit, FeedbackState>(
          builder: (context, state) {
            //
            final cubit = context.watch<FeedbackCubit>();
            // cubit.getFeedbackByTuteeId(authorizedTutor.id);
            cubit.getFeedbackByTutorId(1);
            //
            if (state is FeedbackErrorState) {
              // return ErrorScreen();
              return Text(state.errorMessage);
            } else if (state is InitialFeedbackState) {
              return buildLoadingIndicator();
            } else if (state is FeedbackNoDataState) {
              return NoDataScreen();
            } else if (state is FeedbackListLoadedState) {
              return ListView.builder(
                  itemCount: state.feedbacks.length,
                  itemBuilder: (context, index) => FeedbackCard(feedbacks: state.feedbacks[index],));
            }
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: mainColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: backgroundColor,
          size: 15,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Feedbacks',
      ),
      // actions: [Icon(Icons.sort)],
    );
  }
}
