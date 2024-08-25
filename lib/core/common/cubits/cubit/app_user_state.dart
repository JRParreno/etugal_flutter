part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserInitial extends AppUserState {}

final class GettingAppUser extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;

  const AppUserLoggedIn(this.user);
}

final class AppUserFail extends AppUserState {
  final String message;

  const AppUserFail(this.message);
}
