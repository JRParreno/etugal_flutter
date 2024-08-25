import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatefulWidget {
  static const String routeName = '/on-boarding';

  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.45;

    return const Scaffold(
      body: SafeArea(
        child: Placeholder(),
      ),
    );
  }

  void goToHomePage() {
    final sharedPreferencesNotifier =
        GetIt.instance<SharedPreferencesNotifier>();

    sharedPreferencesNotifier.setValue(SharedPreferencesKeys.isOnBoarded, true);
    GoRouter.of(context).go(AppRoutes.login.path);
  }
}
