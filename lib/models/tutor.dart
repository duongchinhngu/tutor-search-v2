import 'person.dart';

class Tutor extends Person {
  // final int id;
  // final String fullname;
  // final String gender;
  // final String birthday;
  // final String email;
  // final String phone;
  // final String address;
  // final String status;
  // final int roleId;
  // final String avatarImageLink;
  final String educationLevel;
  final String school;
  final int points;
  final int membershipId;

  Tutor(
      {int id,
      String fullname,
      String gender,
      String birthday,
      String email,
      String phone,
      String address,
      String status,
      int roleId,
      String description,
      String avatarImageLink,
      this.educationLevel,
      this.school,
      this.points,
      this.membershipId})
      : super(id, fullname, gender, birthday, email, phone, address, status,
            roleId, description, avatarImageLink);

  Tutor.constructor(
      int id,
      String fullname,
      String gender,
      String birthday,
      String email,
      String phone,
      String address,
      String status,
      int roleId,
      String description,
      String avatarImageLink,
      this.educationLevel,
      this.school,
      this.points,
      this.membershipId)
      : super(id, fullname, gender, birthday, email, phone, address, status,
            roleId, description, avatarImageLink);

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'],
      fullname: json['fullname'],
      gender: json['gender'],
      birthday: json['birthday'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      roleId: json['roleId'],
      avatarImageLink: json['avatarImageLink'],
      educationLevel: json['educationLevel'],
      school: json['school'],
      points: json['points'],
      membershipId: json['membershipId'],
      description: json['description'],
    );
  }
}
