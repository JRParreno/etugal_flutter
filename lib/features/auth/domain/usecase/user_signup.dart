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
      gender: params.gender,
      address: params.address,
      contactNumber: params.contactNumber,
      birthdate: params.birthdate,
    );
  }
}

class UserSignupParams {
  final String firstName;
  final String lastName;
  final String gender;
  final String password;
  final String confirmPassword;
  final String email;
  final String address;
  final String birthdate;
  final String contactNumber;

  const UserSignupParams({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.password,
    required this.confirmPassword,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.birthdate,
  });
}
