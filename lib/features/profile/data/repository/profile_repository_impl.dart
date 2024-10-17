import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:etugal_flutter/features/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  const ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, String>> uploadGovernmentId(
      {required String userId, required String imagePath}) async {
    try {
      final response = await profileRemoteDataSource.uploadGovernmentId(
        imagePath: imagePath,
        userId: userId,
      );

      return right(response);
    } on Failure catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto(
      {required String userId, required String imagePath}) async {
    try {
      final response = await profileRemoteDataSource.uploadProfilePhoto(
        imagePath: imagePath,
        userId: userId,
      );

      return right(response);
    } on Failure catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadSelfie(
      {required String userId, required String imagePath}) async {
    try {
      final response = await profileRemoteDataSource.uploadSelfie(
        imagePath: imagePath,
        userId: userId,
      );

      return right(response);
    } on Failure catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
    required String birthdate,
    required String contactNumber,
    required String gender,
  }) async {
    try {
      final response = await profileRemoteDataSource.updateProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        address: address,
        birthdate: birthdate,
        contactNumber: contactNumber,
        gender: gender,
      );

      return right(response);
    } on Failure catch (e) {
      return left(Failure(e.message));
    }
  }
}
