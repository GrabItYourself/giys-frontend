class MeResponse {
  final String id;
  final String role;
  final String email;
  final String googleId;

  MeResponse({
    required this.id,
    required this.role,
    required this.email,
    required this.googleId,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      id: json['id'],
      role: json['role'],
      email: json['email'],
      googleId: json['google_id'],
    );
  }
}
