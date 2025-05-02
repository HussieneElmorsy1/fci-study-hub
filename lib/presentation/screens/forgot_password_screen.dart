import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/presentation/widgets/custom_bottom.dart';
import 'package:fci_app_new/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final email = ''.obs; // Change to observable type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '2.1'.tr,// "استعادة كلمة المرور"
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '2.2'.tr,// "يرجى إدخال ايميلك الجامعي لتلقي رمز التحقق"
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            CustomFormTextField(
              labelText: '1.2'.tr,// "البريد الالكتروني"
              helperText: '1.4'.tr,// "مرحبا, من فضلك ادخل بريدك الالكتروني"
              keyboardType: TextInputType.emailAddress,
              icon: Icons.attach_email,
              obscureText: false,
              onChanged: (data) {
                email.value = data; // Update to use observable
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '1.10'.tr;// "من فضلك ادخل بريدك الالكتروني"
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return '1.11'.tr;// "ادخل بريد الكتروني صحيح"
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomBottom(
              text: '2.3'.tr,//Send code"
              onPressed: () {
                Get.offNamed(AppRoutes.MAIN_HOME_SCREEN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
