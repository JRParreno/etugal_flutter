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
  final int age;
  final String password;
  final String confirmPassword;
  final String email;

  const AuthSignupEvent({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.password,
    required this.confirmPassword,
    required this.email,
  });

  @override
  List<Object> get props => [
        firstName,
        lastName,
        age,
        password,
        confirmPassword,
        email,
      ];
}
