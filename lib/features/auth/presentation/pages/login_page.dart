import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            LoadingScreen.instance().show(context: context);
          }

          if (state is AuthFailure || state is AuthSuccess) {
            Future.delayed(const Duration(milliseconds: 500), () {
              LoadingScreen.instance().hide();
            });
          }

          if (state is AuthFailure) {
            onFormError(state.message);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        'Welcome back!',
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          color: ColorName.primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Sign in your account',
                        style: textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 43),
                  AuthField(
                    controller: emailCtrl,
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: ColorName.greyFont,
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: passwordCtrl,
                    hintText: 'Password',
                    isObscureText: isObscureText,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: ColorName.greyFont,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => isObscureText = !isObscureText),
                      icon: Icon(
                        isObscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorName.greyFont,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        context.pushNamed(AppRoutes.forgotPassword.name);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: ColorName.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedBtn(
                    onTap: handleSubmitLogin,
                    title: 'Sign in',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: () {
                      router.pushNamed(AppRoutes.signup.name);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        children: const [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: ColorName.primary,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleSubmitLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthLoginEvent(
                email: emailCtrl.value.text, password: passwordCtrl.value.text),
          );
    }
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'Login Error',
        message: message,
      );
    });
  }
}
