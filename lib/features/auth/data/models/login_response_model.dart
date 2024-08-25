import 'package:etugal_flutter/features/auth/data/models/index.dart';
import 'package:etugal_flutter/features/auth/domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      accessToken: map['access_token'],
      refreshToken: map['refresh_token'],
      user: UserModel.fromMap(map),
    );
  }
}
