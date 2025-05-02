import 'package:fci_app_new/presentation/controllers/login_controller.dart';
import 'package:fci_app_new/presentation/widgets/login_widgets.dart';
import 'package:fci_app_new/presentation/widgets/microsoft_login_button.dart';
import 'package:fci_app_new/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: _controller.isLoading.value,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Form(
              key: _controller.formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        _buildLogo(),
                        const SizedBox(height: 20),
                        _buildTitle(),
                        const SizedBox(height: 20),
                        _buildSubTitle(),
                        const SizedBox(height: 5),
                        _buildSubTitle2(),
                        const SizedBox(height: 80),
                        EmailField(controller: _controller),
                        const SizedBox(height: 10),
                        PasswordField(controller: _controller),
                        const SizedBox(height: 10),
                        LoginButton(controller: _controller),
                        const SizedBox(height: 10),
                        _buildForgotPasswordButton(),
                        AppGaping.kGap15,
                        _buildMicrosoftLoginButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'assets/images/login_screen/Vector.svg',
      height: 150,
      width: 150,
    );
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Text('1.7'.tr, style: AppTextStyles.headline1),
        Text('1.7'.tr, style: AppTextStyles.headline1Fill),
      ],
    );
  }

  Widget _buildSubTitle() {
    return Text(
      '1.8'.tr,
      style: AppTextStyles.bodyText,
    );
  }

  Widget _buildSubTitle2() {
    return Text(
      '1.9'.tr,
      style: AppTextStyles.bodyText,
    );
  }

  Widget _buildForgotPasswordButton() {
    return Obx(() => TextButton(
          onPressed: () {
            _controller.textColor.value = Colors.blue;
            _controller.navigateToForgotPassword();
          },
          child: Text(
            '1.6'.tr,
            style: TextStyle(color: _controller.textColor.value),
          ),
        ));
  }

  Widget _buildMicrosoftLoginButton() {
    return MicrosoftLoginButton(
      onPressed: _controller
          .signInWithMicrosoft, // تأكد من وجود هذه الدالة في الـ controller
    );
  }
}
