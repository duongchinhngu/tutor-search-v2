import '../course.dart';

class CourseTutor extends Course {
  final String fullname;
  final String gender;
  final String birthday;
  final String email;
  final String phone;
  final String address;
  final String avatarImageLink;
  double distance;

  CourseTutor.fromJsonConstructor( {
    int id,
    String name,
    String beginTime,
    String endTime,
    String studyForm,
    double studyFee,
    String daysInWeek,
    String beginDate,
    String endDate,
    String description,
    String status,
    int classHasSubjectId,
    int createdBy,
    String createdDate,
    String confirmedDate,
    int confirmedBy,
    int maxTutee,
    String location,
    this.fullname,
    this.gender,
    this.birthday,
    this.email,
    this.phone,
    this.address,
    this.avatarImageLink,
    this.distance,
  }) : super(
          id,
          name,
          beginTime,
          endTime,
          studyFee,
          daysInWeek,
          beginDate,
          endDate,
          description,
          status,
          classHasSubjectId,
          createdBy,
          maxTutee,
          location,
        );

  CourseTutor(
    int id,
    String name,
    String beginTime,
    String endTime,
    String studyForm,
    double studyFee,
    String daysInWeek,
    String beginDate,
    String endDate,
    String description,
    String status,
    int classHasSubjectId,
    int createdBy,
    String createdDate,
    String confirmedDate,
    int confirmedBy,
    int maxTutee,
    String location,
    this.fullname,
    this.gender,
    this.birthday,
    this.email,
    this.phone,
    this.address,
    this.avatarImageLink,
  ) : super(
          id,
          name,
          beginTime,
          endTime,
          studyFee,
          daysInWeek,
          beginDate,
          endDate,
          description,
          status,
          classHasSubjectId,
          createdBy,
          maxTutee,
          location,
        );

  factory CourseTutor.fromJson(Map<String, dynamic> json) {
    return CourseTutor.fromJsonConstructor(
      id: json['id'],
      fullname: json['fullname'].toString(),
      gender: json['gender'],
      birthday: json['birthday'].toString(),
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      name: json['name'],
      beginTime: json['beginTime'].toString().substring(11),
      endTime: json['endTime'].toString().substring(11),
      studyFee: json['studyFee'].toDouble(),
      daysInWeek: json['daysInWeek'],
      beginDate: json['beginDate'].toString(),
      endDate: json['endDate'].toString(),
      description: json['description'],
      classHasSubjectId: json['classHasSubjectId'],
      createdBy: json['createdBy'],
      confirmedBy: json['confirmedBy'],
      confirmedDate: json['confirmedDate'],
      createdDate: json['createdDate'],
      maxTutee: json['maxTutee'],
      avatarImageLink: json['avatarImageLink'],
      distance: 0.0,
      location: json['location'],
    );
  }
}
