class ReportType {
  final int id;
  final String name;
  final int roleId;
  final String description;

  ReportType.constructor(this.id, this.name, this.roleId, this.description);
  ReportType({this.id, this.name, this.roleId, this.description});

  factory ReportType.fromJson(Map<String, dynamic> json) {
    return ReportType(
      id: json['id'],
      name: json['name'],
      roleId: json['roleId'],
      description: json['description'],
    );
  }
}
