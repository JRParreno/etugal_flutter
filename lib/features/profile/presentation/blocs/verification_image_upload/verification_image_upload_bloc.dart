import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/profile/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_image_upload_event.dart';
part 'verification_image_upload_state.dart';

class VerificationImageUploadBloc
    extends Bloc<VerificationImageUploadEvent, VerificationImageUploadState> {
  final UploadGovernmentId _uploadGovernmentId;
  final UploadSelfie _uploadSelfie;

  VerificationImageUploadBloc({
    required UploadGovernmentId uploadGovernmentId,
    required UploadSelfie uploadSelfie,
  })  : _uploadGovernmentId = uploadGovernmentId,
        _uploadSelfie = uploadSelfie,
        super(VerificationImageUploadInitial()) {
    on<UploadImageInitialEvent>(onUploadImageInitialEvent);
    on<UploadIDImageEvent>(onUploadIDImageEvent);
    on<UploadSelfieImageEvent>(onUploadSelfieImageEvent);
  }

  FutureOr<void> onUploadImageInitialEvent(UploadImageInitialEvent event,
      Emitter<VerificationImageUploadState> emit) async {
    emit(VerificationImageUploadInitial());
  }

  FutureOr<void> onUploadIDImageEvent(UploadIDImageEvent event,
      Emitter<VerificationImageUploadState> emit) async {
    emit(VerificationImageUploadLoading());

    final response = await _uploadGovernmentId.call(
      UploadImageParams(
        imagePath: event.imagePath,
        userId: event.userId,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    response.fold(
      (l) => emit(VerificationImageUploadFailure(l.message)),
      (r) => emit(VerificationImageUploadSuccess(r)),
    );
  }

  FutureOr<void> onUploadSelfieImageEvent(UploadSelfieImageEvent event,
      Emitter<VerificationImageUploadState> emit) async {
    emit(VerificationImageUploadLoading());

    final response = await _uploadSelfie.call(
      UploadImageParams(
        imagePath: event.imagePath,
        userId: event.userId,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    response.fold(
      (l) => emit(VerificationImageUploadFailure(l.message)),
      (r) => emit(VerificationImageUploadSuccess(r)),
    );
  }
}
