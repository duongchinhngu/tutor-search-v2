class Tutor {
  final int id;
  final String fullname;
  final String gender;
  final String birthday;
  final String email;
  final String phone;
  final String address;
  final String status;
  final int roleId;
  //
  final String educationLevel;
  final String school;
  final int points;
  final int membershipId;
  final String description;

  Tutor(
      {this.id,
      this.fullname,
      this.gender,
      this.birthday,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.roleId,
      this.educationLevel,
      this.school,
      this.points,
      this.membershipId,
      this.description});

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
      educationLevel: json['educationLevel'],
      school: json['school'],
      points: json['points'],
      membershipId: json['membershipId'],
      description: json['description'],
    );
  }
}
