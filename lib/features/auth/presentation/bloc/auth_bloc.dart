import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/auth/domain/usecase/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferencesNotifier _sharedPreferencesNotifier;
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignup userSignup,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required SharedPreferencesNotifier sharedPreferencesNotifier,
    required AppUserCubit appUserCubit,
  })  : _userSignup = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _sharedPreferencesNotifier = sharedPreferencesNotifier,
        super(AuthInitial()) {
    on<AuthSignupEvent>(onAuthSignupEvent);
    on<AuthLoginEvent>(onAuthLoginEvent);
    on<AuthIsUserLoggedIn>(onAuthIsUserLoggedIn);
    on<AuthRefreshUser>(onAuthRefreshUser);
  }

  Future<void> onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _currentUser(NoParams());

    response.fold(
      (l) => handleFailSetUserCubit(message: l.message, emit: emit),
      (r) => handleSetUserCubit(emit: emit, user: r),
    );
  }

  Future<void> onAuthRefreshUser(
      AuthRefreshUser event, Emitter<AuthState> emit) async {
    _appUserCubit.userLoggedIn();

    final response = await _currentUser(NoParams());

    response.fold(
      (l) => handleFailSetUserCubit(message: l.message, emit: emit),
      (r) => handleSetUserCubit(emit: emit, user: r),
    );
  }

  Future<void> onAuthLoginEvent(
      AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        // this will save token in localstorage
        handleSetInfo(accessToken: r.accessToken, refreshToken: r.refreshToken);
        // handle set user cubit and emit
        handleSetUserCubit(emit: emit, user: r.user);
      },
    );
  }

  Future<void> onAuthSignupEvent(
      AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final response = await _userSignup.call(UserSignupParams(
      firstName: event.firstName,
      lastName: event.lastName,
      age: event.age,
      password: event.password,
      confirmPassword: event.confirmPassword,
      email: event.email,
    ));

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        // this will save token in localstorage
        handleSetInfo(accessToken: r.accessToken, refreshToken: r.refreshToken);
        // handle set user cubit and emit
        handleSetUserCubit(emit: emit, user: r.user);
      },
    );
  }

  void handleSetInfo(
      {required String accessToken, required String refreshToken}) {
    _sharedPreferencesNotifier.setValue(SharedPreferencesKeys.isLoggedIn, true);
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.accessToken, accessToken);
    _sharedPreferencesNotifier.setValue(
        SharedPreferencesKeys.refreshToken, refreshToken);
  }

  void handleSetUserCubit(
      {required User user, required Emitter<AuthState> emit}) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void handleFailSetUserCubit(
      {required String message, required Emitter<AuthState> emit}) {
    _appUserCubit.failSetUser(message);
    emit(AuthFailure(message));
  }
}
