class User {
  final String id;
  final String role;
  final String email;
  final String googleId;

  User(
      {required this.id,
      required this.role,
      required this.email,
      required this.googleId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        role: json['role'],
        email: json['email'],
        googleId: json['google_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['email'] = email;
    data['google_id'] = googleId;
    return data;
  }
}
