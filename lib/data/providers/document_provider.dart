import 'package:fci_app_new/core/utils/pdf_data.dart';
import 'package:flutter/material.dart';
import '../models/document_collection.dart';
import '../models/pdf_document.dart';

class DocumentProvider extends ChangeNotifier {
  // قائمة لتخزين المجموعات (collections)
  final List<DocumentCollection> _collections = [];
  // قائمة لتخزين الفيديوهات
  final List<PdfDocument> _videos = [];
  // متغير لمعرفة حالة التحميل (هل البيانات يتم تحميلها أم لا)
  bool _isLoading = false;
  // متغير لتخزين الخطأ في حال حدوثه
  String? _error;

  DocumentProvider() {
    // إضافة مستمع للمرحلة بعد بناء واجهة المستخدم (بعد الانتهاء من بناء الواجهة)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // استدعاء دوال تهيئة المجموعات والفيديوهات بعد بناء الواجهة
      _initializeCollections();
      _initializeVideos();
    });
  }

  // الوصول إلى المجموعات
  List<DocumentCollection> get collections => _collections;
  // الوصول إلى الفيديوهات
  List<PdfDocument> get videos => _videos;
  // معرفة حالة التحميل
  bool get isLoading => _isLoading;
  // الوصول إلى رسالة الخطأ إذا كانت موجودة
  String? get error => _error;

  // تهيئة المجموعات (Collections)
  void _initializeCollections() {
    _isLoading = true;
    // استخدام Future.microtask لضمان أنه يتم تحديث الـ state بعد بناء واجهة المستخدم
    Future.microtask(() {
      try {
        // إضافة مجموعة محاضرات
        _collections.add(
          DocumentCollection(
            id: 'lectures',
            title: 'محاضرات',
            category: 'محاضرة',
            documents: PdfData.getLectureDocuments(),
            createdAt: DateTime.now(),
          ),
        );

        // إضافة مجموعة سكشن
        _collections.add(
          DocumentCollection(
            id: 'sections',
            title: 'سكشن',
            category: 'سكشن',
            documents: PdfData.getSectionDocuments(),
            createdAt: DateTime.now(),
          ),
        );

        // إضافة مجموعة فيديو (بدون مستندات في الوقت الحالي)
        _collections.add(
          DocumentCollection(
            id: 'videos',
            title: 'فيديو',
            category: 'فيديو',
            documents: [],
            createdAt: DateTime.now(),
          ),
        );

        // إضافة مجموعة الواجبات
        _collections.add(
          DocumentCollection(
            id: 'homework',
            title: 'الواجبات',
            category: 'الواجبات',
            documents: PdfData.getHomeworkDocuments(),
            createdAt: DateTime.now(),
          ),
        );

        // بعد تحميل البيانات بنجاح، نقوم بتحديث حالة التحميل
        _isLoading = false;
        // إشعار المستمعين أن البيانات قد تم تحميلها
        notifyListeners();
      } catch (e) {
        // في حالة حدوث خطأ أثناء تحميل البيانات، نقوم بتخزين رسالة الخطأ
        _error = 'حدث خطأ أثناء تحميل البيانات: $e';
        _isLoading = false;
        // إشعار المستمعين بتغيير حالة التحميل
        notifyListeners();
      }
    });
  }

  // تهيئة الفيديوهات
  void _initializeVideos() {
    _isLoading = true;
    // استخدام Future.microtask لتأجيل التحديث بعد بناء الواجهة
    Future.microtask(() {
      try {
        // إضافة الفيديوهات إلى القائمة
        _videos.addAll(PdfData.getVideos());
        _isLoading = false;
        // إشعار المستمعين بتحديث البيانات
        notifyListeners();
      } catch (e) {
        // في حالة حدوث خطأ أثناء تحميل الفيديوهات، نقوم بتخزين رسالة الخطأ
        _error = 'حدث خطأ أثناء تحميل الفيديوهات: $e';
        _isLoading = false;
        // إشعار المستمعين بتغيير حالة التحميل
        notifyListeners();
      }
    });
  }

  // دالة لتحميل الفيديوهات بشكل غير متزامن
  Future<void> getVideos() async {
  _isLoading = true;
  _error = null;

  // إشعار المستمعين بأن البيانات في حالة تحميل بعد إتمام البناء
  Future.delayed(Duration.zero, () {
    notifyListeners();
  });

  try {
    await Future.delayed(const Duration(seconds: 1));
    _videos.clear();
    _videos.addAll(PdfData.getVideos());
  } catch (e) {
    _error = 'حدث خطأ أثناء تحميل الفيديوهات: $e';
  } finally {
    _isLoading = false;

    // إشعار المستمعين بتغيير حالة التحميل بعد إتمام البناء
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}

  // دالة لتبديل حالة المفضلة (إضافة/إزالة)
  void toggleFavorite(String collectionId, String documentId) {
    final collectionIndex = _collections.indexWhere((c) => c.id == collectionId);

    if (collectionIndex >= 0) {
      final collection = _collections[collectionIndex];
      final documentIndex = collection.documents.indexWhere((d) => d.id == documentId);

      if (documentIndex >= 0) {
        final List<PdfDocument> updatedDocs = List.from(collection.documents);
        final doc = updatedDocs[documentIndex];
        final bool isFavorite = doc.isFavorite;

        updatedDocs[documentIndex] = doc.copyWith(
          isFavorite: !isFavorite,
        );

        _collections[collectionIndex] = collection.copyWith(documents: updatedDocs);
        // إشعار المستمعين بتغيير البيانات
        notifyListeners();
      }
    }
  }

  // دالة لتمييز المستند كتم تنزيله
  void markAsDownloaded(String collectionId, String documentId) {
    final collectionIndex = _collections.indexWhere((c) => c.id == collectionId);

    if (collectionIndex >= 0) {
      final collection = _collections[collectionIndex];
      final documentIndex = collection.documents.indexWhere((d) => d.id == documentId);

      if (documentIndex >= 0) {
        final List<PdfDocument> updatedDocs = List.from(collection.documents);
        final targetDoc = updatedDocs[documentIndex];

        if (!targetDoc.isDownloaded) {
          updatedDocs[documentIndex] = targetDoc.copyWith(isDownloaded: true);
          _collections[collectionIndex] = _collections[collectionIndex].copyWith(
            documents: updatedDocs,
          );
          // إشعار المستمعين بتغيير البيانات
          notifyListeners();
        }
      }
    }
  }

  // دالة لإزالة علامة التنزيل من المستند
  void removeDownloadedMark(String collectionId, String documentId) {
    final collectionIndex = _collections.indexWhere((c) => c.id == collectionId);

    if (collectionIndex >= 0) {
      final collection = _collections[collectionIndex];
      final documentIndex = collection.documents.indexWhere((d) => d.id == documentId);

      if (documentIndex >= 0) {
        final List<PdfDocument> updatedDocs = List.from(collection.documents);
        final targetDoc = updatedDocs[documentIndex];

        if (targetDoc.isDownloaded) {
          updatedDocs[documentIndex] = targetDoc.copyWith(isDownloaded: false);
          _collections[collectionIndex] = _collections[collectionIndex].copyWith(
            documents: updatedDocs,
          );
          // إشعار المستمعين بتغيير البيانات
          notifyListeners();
        }
      }
    }
  }

  // دالة لتحديث آخر وقت تم فيه قراءة المستند
  void updateLastRead(String collectionId, String documentId) {
    final collectionIndex = _collections.indexWhere((c) => c.id == collectionId);

    if (collectionIndex >= 0) {
      final collection = _collections[collectionIndex];
      final documentIndex = collection.documents.indexWhere((d) => d.id == documentId);

      if (documentIndex >= 0) {
        final List<PdfDocument> finalDocs = List.from(collection.documents);
        final targetDoc = finalDocs[documentIndex];

        finalDocs[documentIndex] = targetDoc.copyWith(
          lastRead: DateTime.now(),
        );

        _collections[collectionIndex] = _collections[collectionIndex].copyWith(
          documents: finalDocs,
        );

        // إشعار المستمعين بتغيير البيانات
        notifyListeners();
      }
    }
  }

  // دالة لتحديث رقم الصفحة الأخيرة التي تم الوصول إليها في المستند
  void updateLastPage(String collectionId, String documentId, int pageNumber) {
    final collectionIndex = _collections.indexWhere((c) => c.id == collectionId);

    if (collectionIndex >= 0) {
      final collection = _collections[collectionIndex];
      final documentIndex = collection.documents.indexWhere((d) => d.id == documentId);

      if (documentIndex >= 0) {
        final List<PdfDocument> finalDocs = List.from(collection.documents);
        final targetDoc = finalDocs[documentIndex];

        finalDocs[documentIndex] = targetDoc.copyWith(
          lastPage: pageNumber,
        );

        _collections[collectionIndex] = _collections[collectionIndex].copyWith(
          documents: finalDocs,
        );

        // إشعار المستمعين بتغيير البيانات
        notifyListeners();
      }
    }
  }
}
