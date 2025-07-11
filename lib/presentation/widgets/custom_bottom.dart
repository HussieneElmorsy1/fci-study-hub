// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fci_app_new/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomBottom extends StatelessWidget {
  CustomBottom({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontFamily: 'pacifico',
          ),
        ),
      ),
    );
  }
}
