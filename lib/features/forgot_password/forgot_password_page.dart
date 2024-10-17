import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/core/enums/view_status.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/features/forgot_password/data/blocs/bloc/forgot_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isForgotPasswordValid = ValueNotifier(true);
  late ForgotPasswordBloc forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Forgot Password',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        bloc: forgotPasswordBloc,
        listener: (context, state) {
          if (state.viewStatus == ViewStatus.loading) {
            LoadingScreen.instance().show(context: context);
          }

          if (state.viewStatus == ViewStatus.failed ||
              state.viewStatus == ViewStatus.successful) {
            Future.delayed(const Duration(milliseconds: 500), () {
              LoadingScreen.instance().hide();
            });

            if (state.viewStatus == ViewStatus.successful) {
              onPageSuccess(
                  "Successfully sent in your email. Kindly check the spam if you don't see the email");
            }
            if (state.viewStatus == ViewStatus.failed) {
              onFormError('Something went wrong.');
            }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Form(
                    key: formKey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: isForgotPasswordValid,
                            builder: (context, isForgotPasswordValid, child) {
                              return Column(
                                children: [
                                  AuthField(
                                    controller: emailController,
                                    hintText: 'Email Address',
                                    validator: (value) {
                                      if (value != null &&
                                          EmailValidator.validate(value)) {
                                        return null;
                                      }
                                      return "Please enter a valid email";
                                    },
                                  ),
                                  if (!isForgotPasswordValid) ...[
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Please enter a valid email',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ].withSpaceBetween(height: 10),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomElevatedBtn(
                            title: 'Submit',
                            onTap: () {
                              isForgotPasswordValid.value = emailController
                                      .text.isNotEmpty &&
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(emailController.text);
                              if (isForgotPasswordValid.value) {
                                forgotPasswordBloc.add(
                                  SendForgotPasswordEvent(
                                    email: emailController.text,
                                  ),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message: message,
      );
    });
  }

  void onPageSuccess(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'E-Tugal',
        message: message,
      ).whenComplete(() {
        Future.delayed(const Duration(milliseconds: 300), () {
          context.pop();
        });
      });
    });
  }
}
