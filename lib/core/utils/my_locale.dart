import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          // App title and common texts
          "app_title": "التطبيق التعليمي",
          "e_government": "الحكومة الالكترونية",
          "search": "بحث",
          
          // Tab names
          "lecture": "محاضرة",
          "section": "سكشن",
          "video": "فيديو",
          "homework": "الواجبات",
          
          // Document titles
          "lecture_1": "المحاضرة الأولى",
          "lecture_2": "المحاضرة الثانية",
          "lecture_3": "المحاضرة الثالثة",
          "lecture_4": "المحاضرة الرابعة",
          "document_name": "اسم المستند",
          
          // Messages
          "no_documents": "لا توجد مستندات متاحة",
          "downloading": "جاري تحميل المستند...",
          "download_success": "تم تحميل المستند بنجاح",
          "opening_document": "جاري فتح المستند...",
          "search_not_available": "البحث غير متاح حاليًا",
          
          // Navigation
          "back": "رجوع",
          "forward": "التالي",
          "cannot_go_back": "لا يمكن العودة للخلف",
        },
        "en": {
          // App title and common texts
          "app_title": "Educational App",
          "e_government": "E-Government",
          "search": "Search",
          
          // Tab names
          "lecture": "Lecture",
          "section": "Section",
          "video": "Video",
          "homework": "Homework",
          
          // Document titles
          "lecture_1": "First Lecture",
          "lecture_2": "Second Lecture",
          "lecture_3": "Third Lecture",
          "lecture_4": "Fourth Lecture",
          "document_name": "Document Name",
          
          // Messages
          "no_documents": "No documents available",
          "downloading": "Downloading document...",
          "download_success": "Document downloaded successfully",
          "opening_document": "Opening document...",
          "search_not_available": "Search is not available yet",
          
          // Navigation
          "back": "Back",
          "forward": "Forward",
          "cannot_go_back": "Cannot go back",
        },
      };
}