import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/features/profile/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppUserCubit, AppUserState>(
          builder: (context, state) {
            if (state is AppUserLoggedIn) {
              return Stack(
                children: [
                  Container(
                    height: mediaQuery.size.height,
                    width: mediaQuery.size.width,
                    margin: EdgeInsets.only(
                      top: mediaQuery.size.height * 0.18,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorName.containerStroke,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.settings_outlined,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin:
                          EdgeInsets.only(top: mediaQuery.size.height * 0.08),
                      child: ProfileAvatarDetail(
                        user: state.user,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child:
                  CustomElevatedBtn(onTap: handleOnTapLogout, title: 'Logout'),
            );
          },
        ),
      ),
    );
  }

  void handleOnTapLogout() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Logout',
      message: 'Do you want to logout',
      canPop: true,
      okLabel: 'Ok',
      cancelLabel: 'Cancel',
    );

    if (result.name != OkCancelResult.cancel.name) {
      final sharedPreferencesNotifier =
          GetIt.instance<SharedPreferencesNotifier>();

      sharedPreferencesNotifier.setValue(
          SharedPreferencesKeys.isLoggedIn, false);
      if (mounted) {
        context.read<AppUserCubit>().logout();

        context.go(AppRoutes.onBoarding.path);
      }
    }
  }
}
