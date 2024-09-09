import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.onSubmit,
    this.expands = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmit;
  final bool expands;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      autocorrect: false,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      style: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: ColorName.blackFont,
        letterSpacing: 0.5,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      onEditingComplete: onSubmit,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
    );
  }
}
