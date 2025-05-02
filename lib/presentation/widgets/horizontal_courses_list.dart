import 'dart:developer';

import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalCoursesList extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.18'.tr, // 'الشبكات العصبية',
    },
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.19'.tr, // 'الحكومة الإلكترونية',
    },
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.20'.tr, // 'أمن المعلومات',
    },
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.21'.tr, // 'شبكات المؤسسات',
    },
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.22'.tr, // 'قواعد البيانات الوسائط المتعددة',
    },
    {
      'image': 'assets/images/home_screen/neural_networks.png',
      'title': '3.23'.tr, // 'قواعد البيانات المتسلسلة زمنياً',
    },
  ];

  HorizontalCoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320, // ارتفاع إضافي لظل البطاقات
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: _buildCard(context, items[index], index),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, String> item, int index) {
    return InkWell(
      onTap: () {
        log('تم اختيار: ${item['title']}');
        Get.toNamed(
          AppRoutes.PDF_SCREEN,
          arguments: items[index]['title']!,
        );
      },
      child: Container(
        width: 190,
        height: 280,
        margin: const EdgeInsets.only(right: 14), // مسافة بين البطاقات
        child: Column(
          children: [
            // البطاقة الرئيسية
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // الصورة
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      item['image']!,
                      width: 190,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      item['title']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
