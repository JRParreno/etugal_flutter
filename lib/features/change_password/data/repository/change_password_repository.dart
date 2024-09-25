import 'package:etugal_flutter/features/change_password/domain/models/change_password_response.dart';

abstract class ChangePasswordRepository {
  Future<ChangePasswordResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
