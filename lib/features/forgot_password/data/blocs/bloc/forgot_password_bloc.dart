import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/features/forgot_password/data/repository/forgot_password_repository.dart';
import 'package:etugal_flutter/features/forgot_password/domain/models/forgot_password_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc({
    required this.forgotPasswordRepository,
  }) : super(
          ForgotPasswordInitial(
            viewStatus: ViewStatus.none,
            forgotPassswordResponse: ForgotPasswordResponse.empty(),
          ),
        ) {
    on<SendForgotPasswordEvent>(_onSendForgotPasswordEvent);
  }

  final ForgotPasswordRepository forgotPasswordRepository;

  FutureOr<void> _onSendForgotPasswordEvent(
    SendForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(viewStatus: ViewStatus.loading),
    );
    try {
      final response = await forgotPasswordRepository.sendForgotPasswordEmail(
        email: event.email,
      );
      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          forgotPassswordResponse: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          viewStatus: ViewStatus.failed,
        ),
      );
    }
  }
}
