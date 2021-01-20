class Tutee {
  final int id;
  final String fullname;
  final String gender;
  final DateTime birthday;
  final String email;
  final String phone;
  final String address;
  final String status;
  final int roleId;

  Tutee({this.id, this.fullname, this.gender, this.birthday, this.email, this.phone, this.address, this.status, this.roleId});

  factory Tutee.fromJson(Map<String, dynamic> json) {
    return Tutee(
      id: json['id'],
      fullname: json['fullname'],
      gender: json['gender'],
      birthday: json['birthday'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      status: json['status'],
      roleId: json['roleId'],
    );
  }
}