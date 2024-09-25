part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {}

class CallChangePasswordEvent extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;
  CallChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
  });
  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
      ];
}
