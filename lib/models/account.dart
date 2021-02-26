class Account {
  final int id;
  final String email;
  final int roleId;
  final String description;
  final String status;

  Account({this.id, this.email, this.roleId, this.description, this.status});
  Account.constructor(
      this.id, this.email, this.roleId, this.description, this.status);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'],
      roleId: json['roleId'],
      description: json['description'],
      status: json['status'],
    );
  }

  void showAttribute() {
    print('account email: ' + email);
    print('account role id: ' + roleId.toString());
    print('account status: ' + status);
  }
}
