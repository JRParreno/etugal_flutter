import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class FourthStepForm extends StatelessWidget {
  const FourthStepForm({
    super.key,
    required this.rewardCtrl,
    required this.onNext,
    required this.onSubmit,
  });

  final TextEditingController rewardCtrl;
  final VoidCallback onNext;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reward',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      'How much are you willing to offer?',
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: 'Enter reward',
                      controller: rewardCtrl,
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(top: 15, left: 9),
                        child: Text(
                          'PHP',
                          style: textTheme.bodyMedium?.copyWith(
                            color: ColorName.darkerGreyFont,
                          ),
                        ),
                      ),
                      onSubmit: onSubmit,
                    ),
                  ].withSpaceBetween(height: 10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      'Choose a means of payment',
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: ColorName.borderColor,
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Arrange Payment myself',
                      ),
                    )
                  ].withSpaceBetween(height: 10),
                )
              ].withSpaceBetween(height: 30),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        NextButton(
          title: 'Submit',
          onNext: onNext,
          isEnabled: rewardCtrl.value.text.isNotEmpty,
        ),
      ],
    );
  }
}
