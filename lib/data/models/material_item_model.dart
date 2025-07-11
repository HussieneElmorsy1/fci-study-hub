// lib/data/models/material_item_model.dart
import 'package:get/get.dart'; // For .tr() if used for default values

class MaterialItemModel {
  final String id;
  final String title; // عنوان المادة (مثال: "Introduction to Programming - Week 1")
  final String url; // رابط الملف أو الفيديو
  final String type; // نوع المادة: 'pdf', 'video', 'exam', 'book'
  final String? doctorName; // اسم الدكتور الذي يخص المادة (اختياري، يمكن جلبه من الكورس)
  final String? courseTitle; // عنوان المقرر الذي تنتمي إليه المادة (اختياري)
  final String? thumbnailUrl; // رابط الصورة المصغرة للفيديوهات (من Video model)
  final String? description; // وصف المادة (من PdfDocument أو Video)

  // حقول خاصة بحالة التنزيل والمفضلة والقراءة (من PdfDocument model)
  final bool isDownloaded;
  final bool isFavorite;
  final DateTime? lastRead;
  final int? lastPage; // آخر صفحة تم الوقوف عندها في الـ PDF

  // حقول خاصة بالصلاحيات (للمدرسين) - هذه قد لا ترجع من API المواد، ولكن تُحدد بناءً على دور المستخدم
  final bool canEdit;
  final bool canDelete;

  MaterialItemModel({
    required this.id,
    required this.title,
    required this.url,
    required this.type,
    this.doctorName,
    this.courseTitle,
    this.thumbnailUrl,
    this.description,
    this.isDownloaded = false,
    this.isFavorite = false,
    this.lastRead,
    this.lastPage,
    this.canEdit = false, // افتراضياً الطالب لا يمكنه التعديل
    this.canDelete = false, // افتراضياً الطالب لا يمكنه الحذف
  });

  factory MaterialItemModel.fromJson(Map<String, dynamic> json) {
    // بناءً على الـ API الخاص بك، ستحتاج إلى تكييف هذا التحليل
    // هذا افتراض عام لبنية عنصر المادة من API واحد يرجع أنواع مختلفة
    return MaterialItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? 'عنوان غير معروف'.tr,
      url: json['url'] ?? '', // يجب أن يكون هناك حقل للرابط
      type: json['type'] ?? '', // يجب أن يحدد الـ API نوع المادة (مثال: 'pdf', 'video')
      doctorName: json['DoctorName'], // إذا كان API يرجع اسم الدكتور
      courseTitle: json['courseTitle'], // إذا كان API يرجع عنوان المقرر
      thumbnailUrl: json['thumbnail'], // إذا كان API يرجع صورة مصغرة (للفيديوهات)
      description: json['description'], // إذا كان API يرجع وصفاً

      // هذه الحقول قد لا ترجع من API جلب المواد، بل يتم إدارتها محلياً أو من API آخر
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      lastRead: json['lastRead'] != null ? DateTime.tryParse(json['lastRead']) : null,
      lastPage: json['lastPage'] as int?,
      
      // صلاحيات التعديل والحذف تُحدد بناءً على دور المستخدم بعد المصادقة
      canEdit: json['canEdit'] as bool? ?? false,
      canDelete: json['canDelete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'type': type,
      'DoctorName': doctorName,
      'courseTitle': courseTitle,
      'thumbnail': thumbnailUrl,
      'description': description,
      'isDownloaded': isDownloaded,
      'isFavorite': isFavorite,
      'lastRead': lastRead?.toIso8601String(),
      'lastPage': lastPage,
      'canEdit': canEdit,
      'canDelete': canDelete,
    };
  }
}