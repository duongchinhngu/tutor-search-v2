class Fee {
  final int id;
  final String name;
  final double price;
  final String description;

  Fee({this.id, this.name, this.price, this.description});

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }
}
