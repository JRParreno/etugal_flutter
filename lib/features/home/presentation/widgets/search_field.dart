// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_debounce/easy_debounce.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatelessWidget {
  final String hintText;

  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.onClearText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.onSubmit,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmit;
  final VoidCallback onChanged;
  final VoidCallback onClearText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: ColorName.blackFont,
        letterSpacing: 0.5,
      ),
      onEditingComplete: onSubmit,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: onClearText,
                child: const Icon(
                  Icons.clear,
                ),
              )
            : null,
        suffixIconColor: Colors.red.withOpacity(0.75),
        prefixIcon: prefixIcon,
      ),
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
      onChanged: (value) {
        EasyDebounce.debounce(
            'search-on-change', // <-- An ID for this particular debouncer
            const Duration(milliseconds: 500), // <-- The debounce duration
            () => onChanged() // <-- The target method
            );
      },
    );
  }
}
