part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final ViewStatus viewStatus;
  final ForgotPasswordResponse forgotPassswordResponse;
  const ForgotPasswordState({
    required this.viewStatus,
    required this.forgotPassswordResponse,
  });

  ForgotPasswordState copyWith({
    ViewStatus? viewStatus,
    ForgotPasswordResponse? forgotPassswordResponse,
  }) {
    return ForgotPasswordState(
      viewStatus: viewStatus ?? this.viewStatus,
      forgotPassswordResponse:
          forgotPassswordResponse ?? this.forgotPassswordResponse,
    );
  }

  @override
  List<Object> get props => [viewStatus];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial({
    required super.viewStatus,
    required super.forgotPassswordResponse,
  });
}
