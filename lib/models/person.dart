abstract class Person {
  final int id;
  final String fullname;
  final String gender;
  final String birthday;
  final String email;
  final String phone;
  final String address;
  final String description;
  final String status;
  final int roleId;
  final String avatarImageLink;

  Person(
      this.id,
      this.fullname,
      this.gender,
      this.birthday,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.roleId,
      this.description,
      this.avatarImageLink);
}

class RawUser {
  final int id;
  final String email;

  RawUser({this.id, this.email});
}
