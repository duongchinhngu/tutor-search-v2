class Class {
  final int id;
  final String name;
  final String description;
  final String status;

  Class({this.id, this.name, this.description, this.status});

    factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  
}