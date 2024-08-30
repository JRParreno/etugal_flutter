import 'package:etugal_flutter/core/common/widgets/common_bottomsheet.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/gender_select_widget.dart';
import 'package:etugal_flutter/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
  final genderCtrl = TextEditingController();
  final contactNumberCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isObscureTextPass = true, isObscureTextConfirmPass = true;

  @override
  void initState() {
    super.initState();
    emailCtrl.text = 'jhonrhayparreno22@gmail.com';
    firstNameCtrl.text = 'Juan';
    lastNameCtrl.text = 'Dela Cruz';
    confirmPasswordCtrl.text = '2020Rtutest@';
    passwordCtrl.text = '2020Rtutest@';
    birthdateCtrl.text = '12/22/1997';
    genderCtrl.text = 'Male';
    addressCtrl.text = 'Pasay City';
    contactNumberCtrl.text = '09321764095';
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    confirmPasswordCtrl.dispose();
    passwordCtrl.dispose();
    birthdateCtrl.dispose();
    genderCtrl.dispose();
    addressCtrl.dispose();
    contactNumberCtrl.dispose();
    super.dispose();
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
                        'Create Account',
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          color: ColorName.primary,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Create a new Account',
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
                    height: 15,
                  ),
                  AuthField(
                    controller: firstNameCtrl,
                    hintText: 'First name',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: ColorName.greyFont,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    controller: lastNameCtrl,
                    hintText: 'Last name',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: ColorName.greyFont,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: handleOnTapBirthdate,
                    child: AuthField(
                      enabled: false,
                      controller: birthdateCtrl,
                      hintText: 'Birthdate',
                      prefixIcon: const Icon(
                        Icons.date_range,
                        color: ColorName.greyFont,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => commonBottomSheetDialog(
                      context: context,
                      title: 'Select Gender',
                      container: GenderSelectWidget(
                        onSelectGender: (value) {
                          genderCtrl.value = TextEditingController.fromValue(
                            TextEditingValue(text: value),
                          ).value;
                        },
                        selectedGender:
                            genderCtrl.text.isNotEmpty ? genderCtrl.text : null,
                      ),
                    ),
                    child: AuthField(
                      enabled: false,
                      controller: genderCtrl,
                      hintText: 'Gender',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: ColorName.greyFont,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    controller: contactNumberCtrl,
                    hintText: 'Contact Number',
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: ColorName.greyFont,
                    ),
                    validator: (value) {
                      if (value != null &&
                          RegExp(r'^(09|\+639)\d{9}$').hasMatch(value)) {
                        return null;
                      }
                      return 'Invalid contact number';
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    controller: addressCtrl,
                    hintText: 'Address',
                    prefixIcon: const Icon(
                      Icons.location_pin,
                      color: ColorName.greyFont,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                        color: ColorName.greyFont,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: ColorName.greyFont,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    controller: confirmPasswordCtrl,
                    hintText: 'Confirm Password',
                    isObscureText: isObscureTextConfirmPass,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: ColorName.greyFont,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() =>
                          isObscureTextConfirmPass = !isObscureTextConfirmPass),
                      icon: Icon(
                        isObscureTextConfirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorName.greyFont,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text:
                          "By tapping “Next”, you confirm that you accept our ",
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: "Terms of Use ",
                          style: textTheme.titleSmall?.copyWith(
                            color: ColorName.primary,
                          ),
                        ),
                        TextSpan(
                          text: "& ",
                          style: textTheme.titleSmall,
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: textTheme.titleSmall?.copyWith(
                            color: ColorName.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  CustomElevatedBtn(
                    onTap: handleOnSubmitForm,
                    title: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.login.name),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        children: const [
                          TextSpan(
                            text: "Sign In",
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
              gender: genderCtrl.value.text.toLowerCase(),
              password: passwordCtrl.value.text,
              confirmPassword: confirmPasswordCtrl.value.text,
              email: emailCtrl.value.text,
              address: addressCtrl.value.text,
              contactNumber: contactNumberCtrl.value.text,
              birthdate: birthdateCtrl.value.text,
            ),
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

  void handleOnTapBirthdate() async {
    final birthdate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (birthdate != null) {
      birthdateCtrl.text = DateFormat.yMd().format(birthdate);
    }
  }
}
