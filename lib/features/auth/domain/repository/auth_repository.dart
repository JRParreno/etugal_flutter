import 'package:fpdart/fpdart.dart';
import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/features/auth/domain/entities/login_response.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/auth/domain/entities/signup_response.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, LoginResponse>> loginWithEmailPassword({
    required String email,
    required String password,
  });

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
  });

  Future<Either<Failure, User>> currentUser();
}
