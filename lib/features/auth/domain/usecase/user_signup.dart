// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/auth/domain/entities/signup_response.dart';
import 'package:etugal_flutter/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements UseCase<SingupResponse, UserSignupParams> {
  final AuthRepository authRepository;

  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, SingupResponse>> call(UserSignupParams params) async {
    return await authRepository.signup(
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class UserSignupParams {
  final String firstName;
  final String lastName;
  final int age;
  final String password;
  final String confirmPassword;
  final String email;

  const UserSignupParams({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.password,
    required this.confirmPassword,
    required this.email,
  });
}
