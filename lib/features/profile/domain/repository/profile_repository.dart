import 'package:etugal_flutter/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, String>> uploadGovernmentId({
    required String userId,
    required String imagePath,
  });
  Future<Either<Failure, String>> uploadSelfie({
    required String userId,
    required String imagePath,
  });
  Future<Either<Failure, String>> uploadProfilePhoto({
    required String userId,
    required String imagePath,
  });
}
