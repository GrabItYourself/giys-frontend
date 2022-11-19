class User {
  final String id;
  final String role;
  final String email;
  final String googleId;
  final int? shopId;

  User(
      {required this.id,
      required this.role,
      required this.email,
      required this.googleId,
      this.shopId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        role: json['role'],
        email: json['email'],
        googleId: json['google_id'],
        shopId: json['shop_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['email'] = email;
    data['google_id'] = googleId;
    if (shopId != null) {
      data['shop_id'] = shopId;
    }
    return data;
  }
}
