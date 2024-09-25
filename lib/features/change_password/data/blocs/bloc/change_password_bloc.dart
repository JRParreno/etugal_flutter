import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/change_password/data/repository/change_password_repository.dart';
import 'package:etugal_flutter/features/change_password/domain/models/change_password_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required this.changePasswordRepository,
  }) : super(
          ChangePasswordInitial(
            viewStatus: ViewStatus.none,
            response: ChangePasswordResponse.empty(),
            errorMessage: '',
          ),
        ) {
    on<CallChangePasswordEvent>(_onCallChangePasswordEvent);
  }

  final ChangePasswordRepository changePasswordRepository;

  FutureOr<void> _onCallChangePasswordEvent(
    CallChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final response = await changePasswordRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          response: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      final error = e as Map<String, dynamic>;
      final errorMessage = error["data"] as Map<String, dynamic>;
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
          errorMessage: errorMessage['error_message'].toString(),
        ),
      );
    }
  }
}
