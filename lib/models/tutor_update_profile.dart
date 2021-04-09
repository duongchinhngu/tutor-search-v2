import 'package:tutor_search_system/models/person.dart';

class TutorUpdateProfile extends Person {
  final String educationLevel;
  final String school;
  final String socialIdUrl;
  final String certificateImages;
  final int confirmedBy;
  final String confirmedDate;
  final int points;
  final int membershipId;

  TutorUpdateProfile(
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
    this.socialIdUrl,
    this.certificateImages,
    this.confirmedDate,
    this.points,
    this.membershipId,
    this.confirmedBy,
  ) : super(id, fullname, gender, birthday, email, phone, address, status,
            roleId, description, avatarImageLink);
}
