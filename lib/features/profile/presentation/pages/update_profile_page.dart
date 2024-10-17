import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/common_bottomsheet.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/gender_select_widget.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/auth/presentation/widgets/auth_field.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final emailCtrl = TextEditingController();
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final genderCtrl = TextEditingController();
  final contactNumberCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final birthdateCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final state = context.read<AppUserCubit>().state;

    if (state is AppUserLoggedIn) {
      emailCtrl.text = state.user.email;
      firstNameCtrl.text = state.user.firstName;
      lastNameCtrl.text = state.user.lastName;
      genderCtrl.text = state.user.gender;
      contactNumberCtrl.text = state.user.contactNumber;
      addressCtrl.text = state.user.address;
      birthdateCtrl.text = DateFormat.yMd().format(state.user.birthdate);
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    contactNumberCtrl.dispose();
    genderCtrl.dispose();
    addressCtrl.dispose();
    birthdateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Update Profile'),
      ),
      body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileLoading) {
            LoadingScreen.instance().show(context: context);
          }

          if (state is UpdateProfileFailure || state is UpdateProfileSuccess) {
            Future.delayed(const Duration(milliseconds: 500), () {
              LoadingScreen.instance().hide();
            });
          }

          if (state is UpdateProfileSuccess) {
            onPageSuccess('Successfully updated.');
          }

          if (state is UpdateProfileFailure) {
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
                  const SizedBox(height: 20),
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
                  const SizedBox(
                    height: 26,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  CustomElevatedBtn(
                    onTap: handleOnSubmitForm,
                    title: 'Update',
                  ),
                  const SizedBox(
                    height: 26,
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
      context.read<UpdateProfileBloc>().add(
            UpdateProfileTrigger(
              firstName: firstNameCtrl.value.text,
              lastName: lastNameCtrl.value.text,
              email: emailCtrl.value.text,
              address: addressCtrl.value.text,
              birthdate: birthdateCtrl.value.text,
              contactNumber: contactNumberCtrl.value.text,
              gender: genderCtrl.value.text,
            ),
          );
    }
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'Profile',
        message: message,
      );
    });
  }

  void onPageSuccess(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'Profile',
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
