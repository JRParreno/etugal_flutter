class ChangePasswordResponse {
  final String status;
  final int code;
  final String message;

  ChangePasswordResponse({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ChangePasswordResponse.empty() {
    return ChangePasswordResponse(
      status: '',
      code: 0,
      message: '',
    );
  }

  factory ChangePasswordResponse.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponse(
      status: map['status'] as String,
      code: map['code'] as int,
      message: map['message'] as String,
    );
  }
}
