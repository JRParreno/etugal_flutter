import 'package:etugal_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

final serviceLocator = GetIt.instance;

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscureTextPass = true, isObscureTextConfirmPass = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    confirmPasswordCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  AuthField(
                    controller: emailCtrl,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: firstNameCtrl,
                    hintText: 'Firstname',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: lastNameCtrl,
                    hintText: 'Lastname',
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: passwordCtrl,
                    hintText: 'Password',
                    isObscureText: isObscureTextPass,
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                          () => isObscureTextPass = !isObscureTextPass),
                      icon: Icon(
                        isObscureTextPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  AuthField(
                    controller: confirmPasswordCtrl,
                    hintText: 'Confirm Password',
                    isObscureText: isObscureTextConfirmPass,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() =>
                          isObscureTextConfirmPass = !isObscureTextConfirmPass),
                      icon: Icon(
                        isObscureTextConfirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                    onPressed: handleOnSubmitForm,
                    child: const Text(
                      'Signup',
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
                      router.pop();
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(color: ColorName.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleOnSubmitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignupEvent(
                firstName: firstNameCtrl.value.text,
                lastName: lastNameCtrl.value.text,
                age: 0,
                password: passwordCtrl.value.text,
                confirmPassword: confirmPasswordCtrl.value.text,
                email: emailCtrl.value.text),
          );
    }
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        context: context,
        title: 'Signup Error',
        message: message,
      );
    });
  }
}
