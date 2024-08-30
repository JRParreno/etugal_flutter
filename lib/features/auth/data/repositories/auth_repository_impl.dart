import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:etugal_flutter/features/auth/domain/entities/login_response.dart';
import 'package:etugal_flutter/features/auth/domain/entities/signup_response.dart';
import 'package:etugal_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResponse>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, SingupResponse>> signup({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String gender,
    required String contactNumber,
    required String address,
    required String birthdate,
  }) async {
    try {
      final response = await remoteDataSource.signup(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        confirmPassword: confirmPassword,
        gender: gender,
        address: address,
        contactNumber: contactNumber,
        birthdate: birthdate,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final response = await remoteDataSource.currentUser();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
