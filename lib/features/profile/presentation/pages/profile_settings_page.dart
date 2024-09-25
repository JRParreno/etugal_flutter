import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Settings',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            buildListTile(
              title: 'Change Password',
              onTap: () {
                context.pushNamed(AppRoutes.changePassword.name);
              },
              iconData: Icons.lock,
            ),
            buildListTile(
              title: 'Edit Profile',
              onTap: () {},
              iconData: Icons.edit,
            ),
            buildListTile(
              title: 'Blocked',
              onTap: () {},
              iconData: Icons.block,
            ),
            buildListTile(
                title: 'Terms & Conditions',
                onTap: () {},
                iconData: Icons.shield),
            buildListTile(
              title: 'Report',
              onTap: () {},
              iconData: Icons.report,
            ),
            buildListTile(
              title: 'Logout',
              onTap: handleOnTapLogout,
              iconData: Icons.logout,
            ),
          ].withSpaceBetween(height: 10),
        ),
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    required IconData iconData,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: ColorName.borderColor,
        ),
      ),
      iconColor: ColorName.darkerGreyFont,
      title: Text(
        title,
        style: const TextStyle(color: ColorName.darkerGreyFont),
      ),
      leading: Icon(iconData),
      onTap: onTap,
      trailing: const Icon(
        Icons.chevron_right_outlined,
        size: 30,
        color: ColorName.darkerGreyFont,
      ),
    );
  }

  void handleOnTapLogout() async {
    final result = await showOkCancelAlertDialog(
      context: context,
      style: AdaptiveStyle.iOS,
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
