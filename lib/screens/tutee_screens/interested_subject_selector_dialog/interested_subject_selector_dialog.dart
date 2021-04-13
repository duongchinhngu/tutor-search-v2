import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/notifications/notification_methods.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/subject_cubit.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/repositories/subject_repository.dart';
import 'package:tutor_search_system/screens/common_ui/error_screen.dart';
import 'package:tutor_search_system/states/subject_state.dart';

class InterestedSubjectSelectorDialog extends StatefulWidget {
  @override
  _InterestedSubjectSelectorDialogState createState() =>
      _InterestedSubjectSelectorDialogState();
}

class _InterestedSubjectSelectorDialogState
    extends State<InterestedSubjectSelectorDialog> {
      @override
  void initState() {
    registerOnFirebase();
    getMessage(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectCubit(SubjectRepository()),
      child: BlocBuilder<SubjectCubit, SubjectState>(
        builder: (context, state) {
          //
          final subjectCubit = context.watch<SubjectCubit>();
          subjectCubit.getSubjectsByStatus(StatusConstants.ACTIVE_STATUS);
          //
          if (state is SubjectLoadingState) {
            return Container(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is SubjectLoadFailedState) {
            return ErrorScreen();
          } else if (state is SubjectListLoadedState) {
            //
            return MultiSelectBottomSheet<Subject>(
              title: Text(
                'Subject you\'re interested!',
                style: TextStyle(
                  fontSize: headerFontSize - 1,
                ),
              ),
              items: state.subjects
                  .map((e) => MultiSelectItem(e, e.name))
                  .toList(),
              listType: MultiSelectListType.CHIP,
              initialValue: [],
              searchHint: 'Search by subject name',
              searchable: true,
              itemsTextStyle:
                  TextStyle(fontSize: headerFontSize - 2, color: textGreyColor),
              selectedColor: mainColor,
              selectedItemsTextStyle: TextStyle(
                  fontSize: headerFontSize,
                  color: backgroundColor,
                  fontWeight: FontWeight.bold),
              onConfirm: (value) async {
                List<String> selectedSubjectIds = [];
                //
                for (var i in value) {
                  selectedSubjectIds.add(i.id.toString());
                  print('this is select: ' + selectedSubjectIds.toString());
                }
                //
                if( value.isNotEmpty){
                  //
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setStringList('interestedSubjectsOf' + authorizedTutee.id.toString(), selectedSubjectIds);
                }
                  // // _selectedAnimals.remove(value);
                  
              },
            );
          }
        },
      ),
    );
  }
}
