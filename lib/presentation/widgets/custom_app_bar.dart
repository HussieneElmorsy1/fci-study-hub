import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onForwardPressed;
  final VoidCallback? onSearchPressed;

  const CustomAppBar({
    Key? key,
    this.onBackPressed,
    this.onForwardPressed,
    this.onSearchPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'e_government'.tr,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.search, color: Colors.black),
        onPressed: onSearchPressed ?? () {
          Get.snackbar(
            'Info',
            'search_not_available'.tr,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.black),
          onPressed: onForwardPressed,
        ),
      ],
    );
  }
}