import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.helperText,
    required this.keyboardType,
    required this.icon,
    required this.obscureText,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.controller,
    this.focusNode,
  });

  final String labelText;
  final String helperText;
  final TextInputType keyboardType;
  final IconData icon;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // صندوق الخلفية مع التدرج لمحاكاة الظل الداخلي
        Container(
          height: 60, // ارتفاع الحقل
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white, // لون الحقل الرئيسي
            border: const Border(
              bottom: BorderSide(
                color: Colors.blue, // الحد السفلي الأزرق
                width: 2,
              ),
            ),
          ),
        ),
        // تأثير الظل الداخلي
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 15, // ارتفاع الظل العلوي
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black26, // لون الظل
                  Colors.transparent, // تلاشي الظل لدمجه مع الخلفية
                ],
              ),
            ),
          ),
        ),
        // حقل الإدخال الفعلي
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none, // إزالة الحدود
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            filled: false,
            fillColor: Colors.transparent, // اجعل الخلفية شفافة داخل الحاوية
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            suffixIcon: suffixIcon ??
                Icon(
                  icon,
                  color: Colors.grey.shade400,
                ),

            helperText: helperText,
            helperStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ],
    );
  }
}
