class Account {
  final String email;
  final int roleId;

  Account({this.email, this.roleId,});
  Account.constructor(
      this.email, this.roleId,);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      email: json['email'],
      roleId: json['roleId'],
    );
  }

  void showAttribute() {
    print('account email: ' + email);
    print('account role id: ' + roleId.toString());
  }
}
