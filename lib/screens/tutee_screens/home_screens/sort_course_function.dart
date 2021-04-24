import 'package:tutor_search_system/models/extended_models/course_tutor.dart';

List<CourseTutor> sortByInterestedSubject(
    List<String> interestedSubject, List<CourseTutor> materialCourseList) {
  List<CourseTutor> interestedCourse = [];
  List<CourseTutor> uninterestedCourse = [];
  //set interestedSubjectCourse
  for (var c in materialCourseList) {
    //
    bool isInterested = false;
    for (var i in interestedSubject) {
      //whether or not
      if (c.subjectId == int.parse(i)) {
        //
        print('thi sis interested ' + c.subjectId.toString() + c.name);
        print('==================================');
        interestedCourse.add(c);
        isInterested = true;
        break;
      }
      //
      if (!isInterested) {
        uninterestedCourse.add(c);
      }
    }
  }

  final List<CourseTutor> result = [];
  result.addAll(interestedCourse);
  result.addAll(uninterestedCourse);
  return result;
}

// state.courses
List<CourseTutor> sortAscendingDistance(List<CourseTutor> material) {
  material.sort((a, b) => a.distance.compareTo(b.distance));
  return material;
}
