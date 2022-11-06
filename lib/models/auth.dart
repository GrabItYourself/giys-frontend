class MeResponse {
  final String id;
  final String name;
  final String email;

  MeResponse({
    required this.id,
    required this.name,
    required this.email,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
