import 'dart:developer';

import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/features/auth/domain/usecase/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final SetPushToken _setPushToken;

  AppUserCubit(SetPushToken setPushToken)
      : _setPushToken = setPushToken,
        super(GettingAppUser());

  void updateUser(User? user) async {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      await onCreateFirebaseToken();
      emit(AppUserLoggedIn(user));
    }
  }

  void logout() {
    emit(AppUserInitial());
  }

  void failSetUser(String message) {
    emit(AppUserFail(message));
  }

  void userLoggedIn() {
    emit(GettingAppUser());
  }

  void updateVerificationStatus() {
    final state = this.state;

    if (state is AppUserLoggedIn) {
      emit(
        AppUserLoggedIn(
          state.user.copyWith(verificationStatus: 'PROCESSING_APPLICATION'),
        ),
      );
    }
  }

  void updateIdPhotoField() {
    final state = this.state;

    if (state is AppUserLoggedIn) {
      // define as empty string since this is the only need verification
      emit(
        AppUserLoggedIn(
          state.user.copyWith(idPhoto: ''),
        ),
      );
    }
  }

  Future<void> onCreateFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      log('Successfully created token', name: 'Firebase Messaging');
      await _setPushToken(token);
      return;
    }
  }
}
