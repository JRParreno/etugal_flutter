import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/gen/assets.gen.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RejectVerificationPage extends StatefulWidget {
  const RejectVerificationPage({super.key});

  @override
  State<RejectVerificationPage> createState() =>
      _ProcessVerificationPageState();
}

class _ProcessVerificationPageState extends State<RejectVerificationPage> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
            vertical: 10,
          ),
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
                      'Your appication was rejected',
                      style: textTheme.labelMedium?.copyWith(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<AppUserCubit, AppUserState>(
                      builder: (context, state) {
                        if (state is AppUserLoggedIn) {
                          return Text(
                            state.user.verificationRemarks ?? '',
                            style: textTheme.labelMedium?.copyWith(
                              color: ColorName.darkerGreyFont,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }
                        return const SizedBox();
                      },
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
