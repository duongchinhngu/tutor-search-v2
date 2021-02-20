class ClassHasSubject {
  final int id;
  final int subjectId;
  final int classId;

  ClassHasSubject({this.id, this.subjectId, this.classId});

   factory ClassHasSubject.fromJson(Map<String, dynamic> json) {
    return ClassHasSubject(
      id: json['id'],
      subjectId: json['subjectId'],
      classId: json['classId'],
    );
  }

}