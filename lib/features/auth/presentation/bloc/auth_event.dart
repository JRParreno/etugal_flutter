// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthIsUserLoggedIn extends AuthEvent {}

class AuthRefreshUser extends AuthEvent {}

class AuthSignupEvent extends AuthEvent {
  final String firstName;
  final String lastName;
  final String gender;
  final String password;
  final String confirmPassword;
  final String email;
  final String address;
  final String contactNumber;
  final String birthdate;

  const AuthSignupEvent({
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

  @override
  List<Object> get props => [
        firstName,
        lastName,
        gender,
        password,
        confirmPassword,
        email,
        address,
        contactNumber,
        birthdate,
      ];
}
