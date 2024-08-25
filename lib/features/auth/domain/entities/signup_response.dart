import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/auth/data/models/user_model.dart';

class SingupResponse extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const SingupResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        user,
      ];
}
