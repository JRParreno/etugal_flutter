part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final ViewStatus viewStatus;
  final ChangePasswordResponse response;
  final String errorMessage;

  const ChangePasswordState({
    required this.viewStatus,
    required this.response,
    required this.errorMessage,
  });

  ChangePasswordState copyWith({
    ViewStatus? viewStatus,
    ChangePasswordResponse? response,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      viewStatus: viewStatus ?? this.viewStatus,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [viewStatus];
}

final class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial({
    required super.viewStatus,
    required super.response,
    required super.errorMessage,
  });
}
