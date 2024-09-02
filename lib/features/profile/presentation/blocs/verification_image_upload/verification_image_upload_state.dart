part of 'verification_image_upload_bloc.dart';

sealed class VerificationImageUploadState extends Equatable {
  const VerificationImageUploadState();

  @override
  List<Object> get props => [];
}

final class VerificationImageUploadInitial
    extends VerificationImageUploadState {}

final class VerificationImageUploadLoading
    extends VerificationImageUploadState {}

final class VerificationImageUploadSuccess
    extends VerificationImageUploadState {
  final String message;

  const VerificationImageUploadSuccess(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}

final class VerificationImageUploadFailure
    extends VerificationImageUploadState {
  final String message;

  const VerificationImageUploadFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
