import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/cubits/subject_cubit.dart';
import 'package:tutor_search_system/models/subject.dart';
import 'package:tutor_search_system/repositories/login_repository.dart';
import 'package:tutor_search_system/repositories/subject_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutor_screens/create_course_screens/create_course_screen.dart';
import 'package:tutor_search_system/states/subject_state.dart';

//default color for background
final defaultWhiteBackground = Colors.white.withOpacity(0.20);
//default text white color
final defautWhiteText = Colors.white.withOpacity(0.8);

class SubjectGridScreen extends StatefulWidget {
  @override
  _SubjectGridScreenState createState() => _SubjectGridScreenState();
}

class _SubjectGridScreenState extends State<SubjectGridScreen> {
  //thi sis for test only
  List<Subject> subjectlist = <Subject>[];
  //login repo
  final loginRepository = LoginRepository();
  //this is test
  //
  //need to refactor
  void onValueChange() {
    subjectlist = subjectlist.where((s) => s.name == s.name).toList();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () async {
          //log out func here
          // signout func
          await loginRepository.handleSignOut(context);
          //
        },
        child: Icon(Icons.power_settings_new_rounded),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 10,
        ),
        color: mainColor,
        child: Expanded(
          child: Column(
            children: [
              //search by subject box
              SearchBox(),
              //'Subject' title
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                  top: 15,
                  left: 20,
                ),
                child: Text(
                  'Subjects',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textWhiteColor.withOpacity(0.8),
                  ),
                ),
              ),
              //subject Grid view;
              //load by cubit and repo
              SubjectGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

//SEARCH BOX
class SearchBox extends StatelessWidget {
  SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 60,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 35,
            width: 350,
            margin: EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
            ),
            padding: EdgeInsets.only(
              left: 15,
            ),
            decoration: BoxDecoration(
              color: defaultWhiteBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              textAlign: TextAlign.start,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 13),
                icon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.7),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search by subject name',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: textFontSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//grid view of subject list (all subjects)
class SubjectGridView extends StatefulWidget {
  @override
  _SubjectGridViewState createState() => _SubjectGridViewState();
}

class _SubjectGridViewState extends State<SubjectGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubjectCubit(SubjectRepository()),
      child: BlocBuilder<SubjectCubit, SubjectState>(builder: (context, state) {
        //
        final subjectCubit = context.watch<SubjectCubit>();
        subjectCubit.getAllSubjects();
        //
        if (state is SubjectLoadingState) {
          return buildLoadingIndicator();
        } else if (state is SubjectLoadFailedState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is SubjectListLoadedState) {
          return Expanded(
            child: GridView.builder(
              itemCount: state.subjects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => SubjectGridCard(
                subject: state.subjects[index],
              ),
            ),
          );
        }
      }),
    );
  }
}

// Subject card
class SubjectGridCard extends StatelessWidget {
  final Subject subject;

  const SubjectGridCard({Key key, @required this.subject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateCourseScreen(
              selectedSubject: subject,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: defaultWhiteBackground,
        ),
        alignment: Alignment.center,
        child: Text(
          subject.name,
          style: TextStyle(
            fontSize: headerFontSize,
            color: defautWhiteText.withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
