import 'package:flutter/material.dart';

/// Shows a SnackBar with the given message.
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      // backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      // margin: const EdgeInsets.only(bottom: 600, right: 20, left: 20),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Optionally handle the close action
        },
      ),
    ),
  );
}
