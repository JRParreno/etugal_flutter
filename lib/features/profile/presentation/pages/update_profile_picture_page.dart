import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/update_profile/update_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfilePciturePage extends StatefulWidget {
  static const String routeName = 'update-state-picture-screen';

  const UpdateProfilePciturePage({super.key});

  @override
  State<UpdateProfilePciturePage> createState() =>
      _UpdateProfilePciturePageState();
}

class _UpdateProfilePciturePageState extends State<UpdateProfilePciturePage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile Picture',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
        child: BlocSelector<AppUserCubit, AppUserState, User?>(
          selector: (state) {
            if (state is AppUserLoggedIn) return state.user;

            return null;
          },
          builder: (context, state) {
            if (state == null) {
              return const SizedBox();
            }

            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        backgroundImage: image != null
                            ? Image.file(File(image!.path)).image
                            : state.profilePhoto != null &&
                                    state.profilePhoto!.isNotEmpty
                                ? NetworkImage(state.profilePhoto!)
                                : null,
                        radius: 100,
                        child: (state.profilePhoto != null &&
                                    state.profilePhoto!.isNotEmpty) ||
                                image != null
                            ? null
                            : const Icon(Icons.person, size: 50),
                      ),
                    ),
                  ),
                  CustomElevatedBtn(
                    buttonType: ButtonType.outline,
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? pickImage =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = pickImage;
                      });
                    },
                    title: 'Choose from Gallery',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomElevatedBtn(
                    onTap: image != null ? handleSubmitPhoto : null,
                    title: 'Save',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void handleSubmitPhoto() {
    if (image != null) {
      context.read<UpdateProfileBloc>().add(UpdatePhotoTrigger(image!.path));
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
}
