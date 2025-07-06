import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const Color primaryColor = Color(0xFF1E88E5);
  static const Color accentColor = Color(0xFF1976D2);
  static const Color tabSelectedColor = Color(0xFF0277BD);
  static const Color pdfRedColor = Color(0xFFE53935);
  static const Color backgroundColor = Colors.white;
  static const Color tabBackgroundColor = Color(0xFFF5F5F5);

  // Text Styles
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle tabTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle pdfTitleTextStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle pdfSubtitleTextStyle = TextStyle(
    fontSize: 10.0,
    color: Colors.black87,
  );

  // Tab titles
  static const List<String> tabTitles = [
    'محاضرة',
    'سكشن',
    'فيديو',
    'الواجبات',
  ];

  // Demo PDF documents for first lecture
  static const List<Map<String, String>> lectureOneDocs = [
    {'title': 'المحاضرة الأولى', 'subtitle': ''},
    {'title': 'المحاضرة الثانية', 'subtitle': ''},
    {'title': 'المحاضرة الثالثة', 'subtitle': ''},
    {'title': 'المحاضرة الرابعة', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
    {'title': 'اسم المستند', 'subtitle': ''},
  ];

  static const String baseUrl = "https://fcihub.onrender.com/";
  // رابط بديل للاختبار إذا كان الرابط الأساسي غير متاح
  static const String testBaseUrl = "https://fcihub.onrender.com/";
}
