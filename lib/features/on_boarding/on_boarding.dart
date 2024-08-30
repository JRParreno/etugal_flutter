import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/config/shared_prefences_keys.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:etugal_flutter/gen/assets.gen.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
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
    final spaceTitle = MediaQuery.of(context).size.height * 0.05;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: spaceTitle),
              Text(
                'E-Tugal',
                style: textTheme.displaySmall?.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              Assets.images.onBoarding.onBoarding.image(height: height),
              Text(
                'Welcome',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 45),
              CustomElevatedBtn(
                onTap: () => context.pushNamed(AppRoutes.signup.name),
                title: 'Create an Account',
              ),
              const SizedBox(height: 16),
              CustomElevatedBtn(
                onTap: () => context.pushNamed(AppRoutes.login.name),
                title: 'Login',
                buttonType: ButtonType.outline,
              ),
            ],
          ),
        ),
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
