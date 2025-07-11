// lib/presentation/screens/login_screen.dart
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/presentation/controllers/login_controller.dart'; //
import 'package:fci_app_new/presentation/widgets/login_widgets.dart'; //
// تم إزالة import 'package:fci_app_new/presentation/widgets/microsoft_login_button.dart'; // تم حذف هذا الاستيراد
import 'package:fci_app_new/styles/styles.dart'; //
import 'package:flutter/material.dart'; //
import 'package:flutter_svg/svg.dart'; //
import 'package:get/get.dart'; //
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart'; //
import 'package:fci_app_new/data/helper/rive_controller.dart'; //
import 'package:fci_app_new/core/utils/app_theme.dart'; // لـ AppColors
// تأكد من استيراد هذه الملفات إذا كانت تستخدمها CustomTextField و CustomButton
// import 'package:fci_app_new/presentation/widgets/custom_text_field.dart';
// import 'package:fci_app_new/presentation/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  // الحصول على المتحكم عبر Get.find() لأنه سيتم تهيئته بواسطة الـ Binding
  final LoginController _controller = Get.find<LoginController>(); //
  final TextEditingController emailController = TextEditingController(); //
  final TextEditingController passwordController = TextEditingController(); //
  final FocusNode passwordFocuseNode = FocusNode(); //
  final RxBool isObscureText = true.obs; //
  final riveHelper = RiveAnimationControllerHelper(); //

  LoginScreen({super.key}); //

  @override //
  Widget build(BuildContext context) {
    //
    // استلام الدور المختار من الـ arguments
    final String? role = Get.arguments;
    // يمكنك استخدام 'user' كقيمة افتراضية إذا لم يتم تمرير دور
    final String actualRole = role ?? 'user';

    return Obx(() => ModalProgressHUD(
          //
          inAsyncCall: _controller.isLoading.value, //
          child: Scaffold(
            //
            backgroundColor: AppColors.white, //
            body: Form(
              //
              key: _controller.formKey, //
              child: SingleChildScrollView(
                //
                child: Center(
                  //
                  child: Padding(
                    //
                    padding: const EdgeInsets.symmetric(horizontal: 12), //
                    child: Column(
                      //
                      children: [
                        const SizedBox(height: 100), //
                        _buildLogo(), //
                        const SizedBox(height: 20), //
                        _buildTitle(), //
                        const SizedBox(height: 20), //
                        _buildRoleSubTitle(
                            actualRole), // استخدام العنوان الفرعي الجديد بناءً على الدور
                        const SizedBox(height: 5), //
                        _buildSubTitle2(), // (يظل كما هو)
                        const SizedBox(height: 80), //
                        // تم الاحتفاظ بهذه الـ Widgets كما هي بناءً على طلبك
                        EmailField(
                          //
                          controller: _controller, //
                          riveHelper: riveHelper, //
                          emailController: emailController, //
                        ),
                        const SizedBox(height: 10), //
                        PasswordField(
                          //
                          controller: _controller, //
                          riveHelper: riveHelper, //
                          isObscureText: isObscureText, //
                          passwordController: passwordController, //
                          passwordFocuseNode: passwordFocuseNode, //
                        ),
                        const SizedBox(height: 10), //
                        ElevatedButton(
                          //
                          onPressed: () async {
                            // تمرير الدور إلى دالة تسجيل الدخول
                            final success = await _controller.login(
                              emailController.text,
                              passwordController.text,
                              actualRole,
                            );
                            if (success) {
                              // التوجيه بعد تسجيل الدخول بنجاح
                              Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN); //
                            } else {
                              // عرض رسالة خطأ
                              Get.snackbar(
                                'خطأ في تسجيل الدخول'.tr,
                                'البريد الإلكتروني أو كلمة المرور غير صحيحة'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          child: Text('Login'), //
                        ),
                        const SizedBox(height: 10), //
                        _buildForgotPasswordButton(), //
                        AppGaping.kGap15, //
                        // تم إزالة _buildMicrosoftLoginButton() بشكل كامل
                        // يمكنك إضافة زر للعودة لاختيار الدور هنا إذا أردت
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.ROLE_SELECTION); //
                          },
                          child: Text(
                            'العودة لاختيار الدور'.tr,
                            style: AppTextStyles.bodyText
                                .copyWith(color: AppColors.secondary), //
                          ),
                        ),
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
    //
    return SvgPicture.asset(
      //
      'assets/images/login_screen/Vector.svg', //
      height: 150, //
      width: 150, //
    );
  }

  Widget _buildTitle() {
    //
    return Stack(
      //
      children: [
        //
        Text('1.7'.tr, style: AppTextStyles.headline1), //
        Text('1.7'.tr, style: AppTextStyles.headline1Fill), //
      ],
    );
  }

  // دالة العنوان الفرعي الأصلية (تم الحفاظ عليها دون تغيير)
  Widget _buildSubTitle() {
    //
    return Text(
      //
      '1.8'.tr, //
      style: AppTextStyles.bodyText, //
    );
  }

  Widget _buildSubTitle2() {
    //
    return Text(
      //
      '1.9'.tr, //
      style: AppTextStyles.bodyText, //
    );
  }

  // دالة جديدة لإنشاء العنوان الفرعي بناءً على الدور
  Widget _buildRoleSubTitle(String role) {
    String roleText = (role == 'user') ? 'كطالب' : 'كمدرس';
    return Text(
      'تسجيل الدخول $roleText'.tr,
      style: AppTextStyles.bodyText, //
      textAlign: TextAlign.center,
    );
  }

  Widget _buildForgotPasswordButton() {
    //
    return Obx(() => TextButton(
          //
          onPressed: () {
            //
            _controller.textColor.value = Colors.blue; //
            _controller.navigateToForgotPassword(); //
          },
          child: Text(
            //
            '1.6'.tr, //
            style: TextStyle(color: _controller.textColor.value), //
          ),
        ));
  }

  // تم حذف Widget _buildMicrosoftLoginButton() بشكل كامل
}
