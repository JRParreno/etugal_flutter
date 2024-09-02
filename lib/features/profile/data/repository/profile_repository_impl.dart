import 'package:etugal_flutter/core/error/exceptions.dart';
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
    } on ServerException catch (e) {
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
    } on ServerException catch (e) {
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
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
