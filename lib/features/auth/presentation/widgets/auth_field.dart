// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthField extends StatelessWidget {
  final String hintText;

  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final bool isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      enabled: enabled,
      obscureText: isObscureText,
      controller: controller,
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
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return '$hintText is missing';
            }
            return null;
          },
    );
  }
}
