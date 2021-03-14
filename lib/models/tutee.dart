import 'person.dart';

class Tutee extends Person {
  Tutee(
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
      String avatarImageLink})
      : super(id, fullname, gender, birthday, email, phone, address, status,
            roleId, description, avatarImageLink);

  Tutee.constructor(
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
  ) : super(id, fullname, gender, birthday, email, phone, address, status,
            roleId, description, avatarImageLink);

  factory Tutee.fromJson(Map<String, dynamic> json) {
    return Tutee(
      id: json['id'],
      fullname: json['fullname'],
      gender: json['gender'],
      birthday: json['birthday'].toString().substring(0, 10),
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      avatarImageLink: json['avatarImageLink'],
      status: json['status'],
      roleId: json['roleId'],
    );
  }
}
