class AuthResponse {
  final String message;
  final bool isSuccess;
  final String? token;
  final num userId;

  AuthResponse({
    required this.message,
    required this.isSuccess,
    required this.userId,
    this.token,
  });
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json['message'],
      isSuccess: json['success'],
      userId: json['user_id'] ?? 0,
      token: json['token'],
    );
  }
}
