
class ProjectToken {
  final String token;

  ProjectToken({this.token});

  factory ProjectToken.fromJson(Map<String, dynamic> json) {
    return ProjectToken(
      token: json['token'],
    );
  }

  
}
