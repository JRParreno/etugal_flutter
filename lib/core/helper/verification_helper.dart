import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/enums/verification_status_enum.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerificationHelper {
  static void handleOnTapPostAdd({
    required BuildContext context,
    VoidCallback? defaultAction,
  }) {
    final state = context.read<AppUserCubit>().state;

    if (state is AppUserLoggedIn) {
      final verificationStatus =
          getVerificationStatusFromString(state.user.verificationStatus);

      switch (verificationStatus) {
        case VerificationStatus.processingApplication:
          handleShowAlertVeficationStatus(
            message: 'Your application is on going.',
            afterComplete: () {},
            context: context,
          );
          break;
        case VerificationStatus.unverified:
          handleShowAlertVeficationStatus(
            message: 'Please verify your account first.',
            afterComplete: () {
              if (defaultAction != null) {
                // run this to exit current screen
                // to prevent red screen
                context.pop();
              }
              if (state.user.idPhoto != null) {
                context.pushNamed(AppRoutes.uploadSelfie.name);
                return;
              }
              context.pushNamed(AppRoutes.uploadGovernmentId.name);
            },
            context: context,
          );
          break;
        case VerificationStatus.rejected:
          handleShowAlertVeficationStatus(
            message: 'Your application was rejected.',
            afterComplete: () {
              context.pushNamed(AppRoutes.rejectVerification.name);
            },
            context: context,
          );
          break;
        default:
          if (defaultAction != null) {
            defaultAction();
            return;
          }
          context.pushNamed(AppRoutes.addPostTask.name);
          return;
      }
    }
  }

  static void handleShowAlertVeficationStatus({
    required VoidCallback afterComplete,
    required String message,
    required BuildContext context,
  }) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message: message,
      ).whenComplete(afterComplete);
    });
  }
}
