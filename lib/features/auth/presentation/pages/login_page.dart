import 'package:etugal_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  // Assets.images.auth.login.image(),
                  AuthField(
                    controller: emailCtrl,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: passwordCtrl,
                    hintText: 'Password',
                    isObscureText: isObscureText,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => isObscureText = !isObscureText),
                      icon: Icon(
                        isObscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                    onPressed: handleSubmitLogin,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Signika',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  GestureDetector(
                    onTap: () {
                      router.pushNamed(AppRoutes.signup.name);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: TextStyle(color: ColorName.primary),
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
        context: context,
        title: 'Login Error',
        message: message,
      );
    });
  }
}
