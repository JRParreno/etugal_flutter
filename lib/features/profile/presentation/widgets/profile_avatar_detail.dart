import 'package:etugal_flutter/core/common/entities/user.dart';
import 'package:etugal_flutter/core/enums/verification_status_enum.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatarDetail extends StatelessWidget {
  const ProfileAvatarDetail({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: ColorName.primary,
            backgroundImage: user.profilePhoto != null
                ? Image.network(user.profilePhoto!).image
                : null,
            radius: 80,
            child: user.profilePhoto == null
                ? const Icon(
                    Icons.person_outline,
                    size: 80 * 0.75,
                    color: ColorName.whiteNotMuch,
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (user.verificationStatus.toLowerCase() ==
                      VerificationStatus.verified.name.toLowerCase())
                    const Icon(
                      Icons.verified,
                      size: 20,
                      color: Colors.blue,
                    )
                ].withSpaceBetween(
                  width: 5,
                ),
              ),
              verificationWidget(
                verificationStatus: user.verificationStatus,
                context: context,
              ),
            ].withSpaceBetween(height: 10),
          )
        ],
      ),
    );
  }

  Widget verificationWidget({
    required String verificationStatus,
    required BuildContext context,
  }) {
    switch (getVerificationStatusFromString(verificationStatus)) {
      case VerificationStatus.processingApplication:
        return verifyButton(
          context: context,
          title: 'Processing your application',
          backgroundColor: ColorName.containerStroke,
          onTap: () => context.pushNamed(AppRoutes.processVerification.name),
        );
      case VerificationStatus.unverified:
        return verifyButton(
            context: context,
            title: 'Get verified',
            backgroundColor: ColorName.containerStroke,
            onTap: () {
              if (user.idPhoto != null) {
                context.pushNamed(AppRoutes.uploadSelfie.name);
                return;
              }
              context.pushNamed(AppRoutes.uploadGovernmentId.name);
            });
      case VerificationStatus.rejected:
        return verifyButton(
          context: context,
          title: 'Rejected',
          backgroundColor: ColorName.containerStroke,
          onTap: () {},
        );
      default:
        return const SizedBox();
    }
  }

  Widget verifyButton({
    required String title,
    required Color backgroundColor,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorName.blackFont,
              ),
        ),
      ),
    );
  }
}
