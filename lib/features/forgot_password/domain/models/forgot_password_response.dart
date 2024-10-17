class ForgotPasswordResponse {
  String success;
  ForgotPasswordResponse({
    required this.success,
  });

  factory ForgotPasswordResponse.empty() {
    return ForgotPasswordResponse(
      success: '',
    );
  }

  factory ForgotPasswordResponse.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponse(
      success: map['success'] as String,
    );
  }
}
