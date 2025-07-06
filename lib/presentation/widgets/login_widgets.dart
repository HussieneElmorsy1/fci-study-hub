import 'package:fci_app_new/presentation/controllers/login_controller.dart';
import 'package:fci_app_new/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Email Field مع الحفاظ على الفاليديشن الأصلي
class EmailField extends StatelessWidget {
  final LoginController controller;
  final dynamic riveHelper;
  final TextEditingController emailController;
  final bool isPasswordPage;

  const EmailField({
    Key? key,
    required this.controller,
    required this.riveHelper,
    required this.emailController,
    this.isPasswordPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isPasswordPage) return const SizedBox.shrink();

    return Column(
      children: [
        CustomTextFormField(
          labelText: '1.2'.tr,
          helperText: '1.4'.tr,
          keyboardType: TextInputType.emailAddress,
          icon: Icons.attach_email,
          controller: emailController,
          obscureText: false,
          onChanged: (value) {
            controller.email.value = value;
            // Rive Animation Logic
            if (value.isNotEmpty &&
                value.length <= 13 &&
                !riveHelper.isLookingLeft) {
              riveHelper.addDownLeftController();
            } else if (value.isNotEmpty &&
                value.length > 13 &&
                !riveHelper.isLookingRight) {
              riveHelper.addDownRightController();
            } else if (value.isEmpty) {
              riveHelper.addDownLeftController();
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) return '1.10'.tr;
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
              return '1.11'.tr;
            return null;
          },
        ),
        const SizedBox(height: 18), // Gap(18.h)
      ],
    );
  }
}

// Password Field مع الحفاظ على الفاليديشن الأصلي
class PasswordField extends StatelessWidget {
  final LoginController controller;
  final dynamic riveHelper;
  final RxBool isObscureText;
  final TextEditingController passwordController;
  final FocusNode passwordFocuseNode;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.riveHelper,
    required this.isObscureText,
    required this.passwordController,
    required this.passwordFocuseNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        labelText: '1.3'.tr,
        helperText: '1.5'.tr,
        keyboardType: TextInputType.visiblePassword,
        icon: Icons.password,
        controller: passwordController,
        focusNode: passwordFocuseNode,
        obscureText: isObscureText.value,
        onChanged: (data) => controller.password.value = data,
        suffixIcon: GestureDetector(
          onTap: () {
            if (isObscureText.value) {
              isObscureText.value = false;
              riveHelper.addHandsDownController();
            } else {
              riveHelper.addHandsUpController();
              isObscureText.value = true;
            }
          },
          child: Icon(
            isObscureText.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return '1.12'.tr;
          if (value.length < 6) return '1.13'.tr;
          return null;
        },
      ),
    );
  }
}
