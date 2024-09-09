// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class FormSteps extends StatelessWidget {
  const FormSteps({
    super.key,
    required this.numSteps,
    required this.currentStep,
  });

  final int numSteps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 60),
      child: Wrap(
        children: generateStep(),
      ),
    );
  }

  List<Widget> generateStep() {
    return List.generate(numSteps, (int value) {
      return Container(
        height: 2.5,
        width: 50,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: value == currentStep
              ? ColorName.primary
              : ColorName.darkerGreyFont,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
      );
    }).toList() as List<Widget>;
  }
}
