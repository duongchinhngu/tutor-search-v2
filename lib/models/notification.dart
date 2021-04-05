class Notification {
  final int id;
  final String title;
  final String message;
  final String createdDate;
  final String sendToUser;
  final bool isRead;

  Notification.constructor(this.id, this.title, this.message, this.createdDate,
      this.sendToUser, this.isRead);
  Notification(
      {this.id,
      this.title,
      this.message,
      this.createdDate,
      this.sendToUser,
      this.isRead});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      createdDate: json['createdDate'],
      sendToUser: json['sendToUser'],
      isRead: json['isRead'],
    );
  }
}
