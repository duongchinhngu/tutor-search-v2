class Commission {
  final int id;
  final String name;
  final double rate;
  final String description;

  Commission({this.id, this.name, this.rate, this.description});

  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(
      id: json['id'],
      name: json['name'],
      rate: json['rate'].toDouble(),
      description: json['description'],
    );
  }
}
