import 'package:flutter/material.dart';

class MicrosoftLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const MicrosoftLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(300),
      onTap: onPressed,
      child: Container(
        // padding: const EdgeInsets.all(-10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(300),
        ),
        child: Image.asset(
          'assets/images/login_screen/microsoft_icon.png',
          height: 80,
          width: 100,
        ),
      ),
    );
  }
}
