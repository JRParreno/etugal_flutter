import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/loader.dart';
import 'package:etugal_flutter/features/profile/presentation/blocs/verification_image_upload/verification_image_upload_bloc.dart';
import 'package:etugal_flutter/features/profile/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/assets.gen.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UploadSelfiePage extends StatefulWidget {
  const UploadSelfiePage({super.key});

  @override
  State<UploadSelfiePage> createState() => _UploadSelfiePageState();
}

class _UploadSelfiePageState extends State<UploadSelfiePage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocListener<VerificationImageUploadBloc,
          VerificationImageUploadState>(
        listener: blocListener,
        child: UploadVerifyImage(
          title: 'Face Verification',
          placeholder: Assets.images.verification.govIdPlaceholder.image(
            height: double.infinity,
            width: double.infinity,
          ),
          image: image,
          imagePicker: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? pickImage = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 75);
            setState(() {
              image = pickImage;
            });
          },
          onNext: handleOnNext,
          titleUpload: 'Photo of a selfie',
          description: RichText(
            text: TextSpan(
              text: "Please provide a photo of your selfie",
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.normal,
                color: ColorName.greyFont,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onFormError(String message) {
    Future.delayed(const Duration(milliseconds: 600), () {
      showOkAlertDialog(
        style: AdaptiveStyle.iOS,
        context: context,
        title: 'Upload Error',
        message: message,
      );
    });
  }

  void blocListener(
    BuildContext context,
    VerificationImageUploadState state,
  ) {
    {
      if (state is VerificationImageUploadLoading) {
        LoadingScreen.instance().show(context: context);
      }

      if (state is VerificationImageUploadFailure ||
          state is VerificationImageUploadSuccess) {
        Future.delayed(const Duration(milliseconds: 500), () {
          LoadingScreen.instance().hide();
        });
      }

      if (state is VerificationImageUploadSuccess) {
        context.read<AppUserCubit>().updateVerificationStatus();
        Future.delayed(const Duration(milliseconds: 500), () {
          context.replaceNamed(AppRoutes.processVerification.name);
        });
      }

      if (state is VerificationImageUploadFailure) {
        onFormError(state.message);
      }
    }
  }

  void handleOnNext() {
    final userState = context.read<AppUserCubit>().state;

    if (userState is AppUserLoggedIn) {
      context.read<VerificationImageUploadBloc>().add(
            UploadSelfieImageEvent(
              imagePath: image!.path,
              userId: userState.user.profilePk,
            ),
          );
    }
  }
}
