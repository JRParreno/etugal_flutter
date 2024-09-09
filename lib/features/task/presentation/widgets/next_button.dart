// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.onNext,
    this.isEnabled = false,
  });

  final bool isEnabled;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          // so here your custom shadow goes:
          BoxShadow(
            color: Colors.black
                .withAlpha(20), // the color of a shadow, you can adjust it
            spreadRadius:
                3, //also play with this two values to achieve your ideal result
            blurRadius: 7,
            offset: const Offset(0,
                -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 23,
          vertical: 20,
        ),
        color: Colors.white,
        child: CustomElevatedBtn(
          onTap: isEnabled ? onNext : null,
          title: 'Next',
        ),
      ),
    );
  }
}
