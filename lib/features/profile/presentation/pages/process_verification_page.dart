import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/gen/assets.gen.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProcessVerificationPage extends StatefulWidget {
  const ProcessVerificationPage({super.key});

  @override
  State<ProcessVerificationPage> createState() =>
      _ProcessVerificationPageState();
}

class _ProcessVerificationPageState extends State<ProcessVerificationPage> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    Assets.images.verification.verificationClock.image(),
                    const SizedBox(
                      height: 44,
                    ),
                    Text(
                      'We’re verifying your acccount',
                      style: textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'We’ll let you know when your identity checks are all complete. This usually take up to 24 hours.',
                      style: textTheme.labelMedium?.copyWith(
                        color: ColorName.darkerGreyFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CustomElevatedBtn(
                title: 'Done',
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
