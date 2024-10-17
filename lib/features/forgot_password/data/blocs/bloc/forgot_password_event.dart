part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {}

class SendForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;
  SendForgotPasswordEvent({required this.email});
  @override
  List<Object?> get props => [email];
}
