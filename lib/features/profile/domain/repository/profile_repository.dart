import 'package:etugal_flutter/core/common/entities/user.dart';
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
  Future<Either<Failure, User>> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String birthdate,
    required String contactNumber,
    required String gender,
  });
}
