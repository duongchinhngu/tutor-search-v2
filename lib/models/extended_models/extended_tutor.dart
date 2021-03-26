import '../tutor.dart';

class ExtendedTutor extends Tutor {
  final List<dynamic> certificationUrls;

  ExtendedTutor.constructor(
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
    String educationLevel,
    String school,
    int points,
    int membershipId,
    String socialIdUrl,
    this.certificationUrls,
  ) : super.constructor(
          id,
          fullname,
          gender,
          birthday,
          email,
          phone,
          address,
          status,
          roleId,
          description,
          avatarImageLink,
          educationLevel,
          school,
          points,
          membershipId,
          socialIdUrl,
        );
  ExtendedTutor.fromJsonConstructor({
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
    String educationLevel,
    String school,
    int points,
    int membershipId,
    String socialIdUrl,
    this.certificationUrls,
  }) : super.constructor(
          id,
          fullname,
          gender,
          birthday,
          email,
          phone,
          address,
          status,
          roleId,
          description,
          avatarImageLink,
          educationLevel,
          school,
          points,
          membershipId,
          socialIdUrl,
        );

        factory ExtendedTutor.fromJson(Map<String, dynamic> json) {
    return ExtendedTutor.fromJsonConstructor(
      id: json['id'],
      fullname: json['fullname'],
      gender: json['gender'],
      birthday: json['birthday'].toString().substring(0, 10),
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
      socialIdUrl: json['socialIdUrl'],
      certificationUrls: json['certificationUrls'],
    );
  }
}

// certificationImage: json['certificationImage'].ToList(),