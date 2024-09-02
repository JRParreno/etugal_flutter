part of 'verification_image_upload_bloc.dart';

sealed class VerificationImageUploadEvent extends Equatable {
  const VerificationImageUploadEvent();

  @override
  List<Object> get props => [];
}

final class UploadImageInitialEvent extends VerificationImageUploadEvent {}

final class UploadIDImageEvent extends VerificationImageUploadEvent {
  final String userId;
  final String imagePath;

  const UploadIDImageEvent({
    required this.userId,
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        userId,
        imagePath,
      ];
}

final class UploadSelfieImageEvent extends VerificationImageUploadEvent {
  final String userId;
  final String imagePath;

  const UploadSelfieImageEvent({
    required this.userId,
    required this.imagePath,
  });

  @override
  List<Object> get props => [
        userId,
        imagePath,
      ];
}
