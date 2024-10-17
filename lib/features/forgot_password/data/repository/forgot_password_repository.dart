import 'package:etugal_flutter/features/forgot_password/domain/models/forgot_password_response.dart';

abstract class ForgotPasswordRepository {
  Future<ForgotPasswordResponse> sendForgotPasswordEmail({
    required String email,
  });
}
