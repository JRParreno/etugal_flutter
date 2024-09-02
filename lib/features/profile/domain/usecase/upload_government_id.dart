import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/profile/domain/repository/profile_repository.dart';

import 'package:fpdart/fpdart.dart';

class UploadGovernmentId implements UseCase<String, UploadImageParams> {
  final ProfileRepository profileRepository;

  const UploadGovernmentId(this.profileRepository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) async {
    return await profileRepository.uploadGovernmentId(
      userId: params.userId,
      imagePath: params.imagePath,
    );
  }
}
