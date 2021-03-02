class Image {
  final int id;
  final String imageLink;
  final String imageType;
  final String ownerEmail;

  Image({
    this.id,
    this.imageLink,
    this.imageType,
    this.ownerEmail,
  });
  Image.constructor(
      this.id, this.imageLink, this.imageType, this.ownerEmail);

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      imageLink: json['imageLink'],
      imageType: json['imageType'],
      ownerEmail: json['ownerEmail'],
    );
  }

  void showAttribute() {
    print('Image imageLink: ' + imageLink);
  }
}
