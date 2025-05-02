import 'package:fci_app_new/data/models/pdf_document.dart';

class PdfData {
  // Use a sample PDF for testing
  static const String _samplePdfUrl =
      'assets/pdfs/ntroduction_to_Geographic_Information_Systems_9th_Edition.Pdf';

  // Lecture documents
  static List<PdfDocument> getLectureDocuments() {
    return [
      PdfDocument(
        id: '1',
        title: 'المحاضرة الاولى',
        url:
            "assets/pdfs/ntroduction_to_Geographic_Information_Systems_9th_Edition.Pdf",
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '2',
        title: 'المحاضرة الثانية',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '3',
        title: 'المحاضرة الثالثة',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '4',
        title: 'المحاضرة الرابعة',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '5',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '6',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '7',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '8',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '9',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '10',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '11',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
      PdfDocument(
        id: '12',
        title: 'اسم المستند',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'محاضرة',
      ),
    ];
  }

  // Section documents
  static List<PdfDocument> getSectionDocuments() {
    return [
      PdfDocument(
        id: 's1',
        title: 'سكشن 1',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'سكشن',
      ),
      PdfDocument(
        id: 's2',
        title: 'سكشن 2',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'سكشن',
      ),
      PdfDocument(
        id: 's3',
        title: 'سكشن 3',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'سكشن',
      ),
      PdfDocument(
        id: 's4',
        title: 'سكشن 4',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'سكشن',
      ),
    ];
  }

  // Video documents
  static List<PdfDocument> getVideos() {
    return [
      PdfDocument(
        id: 'vid1',
        title: 'فيديو تعليمي: أساسيات البرمجة',
        url: 'assets/videos/rasol_allah.mp4',
        createdAt: DateTime(2023, 9, 16),
        category: 'فيديو',
        description: 'مذكرة مصاحبة لفيديو الأساسيات',
        isDownloaded: false,
        isFavorite: false,
      ),
      PdfDocument(
        id: 'vid2',
        title: 'فيديو تعليمي: هياكل البيانات المتقدمة',
        url: 'assets/videos/rasol_allah.mp4',
        createdAt: DateTime(2023, 9, 23),
        category: 'فيديو',
        description: 'مذكرة مصاحبة لفيديو هياكل البيانات',
        isDownloaded: false,
        isFavorite: false,
      ),
    ];
  }

  // Homework documents
  static List<PdfDocument> getHomeworkDocuments() {
    return [
      PdfDocument(
        id: 'h1',
        title: 'الواجب 1',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'الواجبات',
      ),
      PdfDocument(
        id: 'h2',
        title: 'الواجب 2',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'الواجبات',
      ),
      PdfDocument(
        id: 'h3',
        title: 'الواجب 3',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'الواجبات',
      ),
      PdfDocument(
        id: 'h4',
        title: 'الواجب 4',
        url: _samplePdfUrl,
        createdAt: DateTime.now(),
        category: 'الواجبات',
      ),
    ];
  }
}
