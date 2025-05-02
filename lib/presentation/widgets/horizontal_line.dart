import 'package:flutter/material.dart';


class HorizontalLine extends StatelessWidget {
  final Color color;

  const HorizontalLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color, // لون الخط
      thickness: 0.5, // سماكة الخط
      height: 0, // المسافة الرأسية حول الخط
      indent: 0, // بداية الخط من الجانب الأيسر
      endIndent: 0, // نهاية الخط من الجانب الأيمن
    );
  }
}
