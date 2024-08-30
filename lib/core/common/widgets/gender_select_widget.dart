import 'package:flutter/material.dart';

class GenderSelectWidget extends StatelessWidget {
  const GenderSelectWidget({
    super.key,
    this.selectedGender,
    required this.onSelectGender,
  });

  final String? selectedGender;
  final Function(String value) onSelectGender;

  @override
  Widget build(BuildContext context) {
    final selection = ['Male', 'Female'];
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: selection.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () =>
              onTapSelectClose(context: context, value: selection[index]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selection[index],
                    style: textTheme.titleSmall,
                  ),
                  if (selection[index] == selectedGender) ...[
                    const Icon(Icons.check),
                  ]
                ],
              ),
              const Divider(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSelectClose({
    required BuildContext context,
    required String value,
  }) {
    onSelectGender(value);
    Navigator.pop(context);
  }
}
