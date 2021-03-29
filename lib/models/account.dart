class Account {
  final int id;
  final String email;
  final int roleId;

  Account({this.id, this.email, this.roleId,});
  Account.constructor(
      this.id, this.email, this.roleId,);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'],
      roleId: json['roleId'],
    );
  }

  void showAttribute() {
    print('account email: ' + email);
    print('account role id: ' + roleId.toString());
  }
}
