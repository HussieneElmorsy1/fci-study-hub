// lib/presentation/screens/pdf_viewer_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart'; // هذا المستورد لن يكون مطلوباً إذا تم تحويل منطق التنزيل إلى GetX
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:fci_app_new/data/models/material_item_model.dart'; //
// import '../../data/providers/document_provider.dart'; // هذا المستورد لن يكون مطلوباً

class PdfViewerScreen extends StatefulWidget {
  final MaterialItemModel material; //

  const PdfViewerScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? _finalPathToDisplay; // المسار النهائي لعرضه (سواء كان محلياً أو URL)
  bool _isLoading = true;
  String _errorMessage = '';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfController;
  late bool _isFavorite;
  late bool _isDownloaded;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.material.isFavorite; //
    _isDownloaded = widget.material.isDownloaded; //
    _pdfController = PdfViewerController();
    _loadPdf(); // دالة جديدة لتعالج تحميل الـ PDF من asset أو network
  }

  Future<void> _loadPdf() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final String sourceUrl = widget.material.url; //

      if (sourceUrl.startsWith('http://') || sourceUrl.startsWith('https://')) {
        // إذا كان رابط شبكة، قم بمحاولة التنزيل أولاً
        final response = await http.get(Uri.parse(sourceUrl));

        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/${widget.material.id}.pdf'; //
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          // منطق تحديث حالة isDownloaded (يحتاج إلى ربط بالـ Controller أو Repository)
          if (!_isDownloaded) {
            // هنا يمكنك استدعاء GetX Controller أو Repository لتحديث حالة isDownloaded في الـ Model/Backend
            _isDownloaded = true;
          }

          _finalPathToDisplay = filePath; // المسار المحلي للملف الذي تم تنزيله
        } else {
          _errorMessage = 'فشل تحميل الملف من الشبكة: ${response.statusCode}';
          _finalPathToDisplay = sourceUrl; // العودة لاستخدام URL إذا فشل التنزيل
        }
      } else if (sourceUrl.startsWith('assets/')) {
        // إذا كان مسار asset محلياً
        _finalPathToDisplay = sourceUrl;
      } else {
        // إذا كان مسار ملف محلي (مثل /data/user/0/...)
        final file = File(sourceUrl);
        if (await file.exists()) {
          _finalPathToDisplay = sourceUrl;
        } else {
          _errorMessage = 'مسار الملف المحلي غير صالح أو الملف غير موجود.';
        }
      }
    } catch (e) {
      _errorMessage = 'خطأ في تحميل الملف: $e';
    } finally {
      setState(() {
        _isLoading = false;
      });
      // بعد تحميل الملف، روح للصفحة الأخيرة (إذا كانت موجودة)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.material.lastPage != null && widget.material.lastPage! > 0) { //
          _pdfController.jumpToPage(widget.material.lastPage!); //
        }
        // هنا يمكنك استدعاء GetX Controller أو Repository لتحديث آخر صفحة مقروءة
      });
    }
  }

  void _toggleFavorite() {
    // هذا الجزء يحتاج لربط بالـ Controller أو Repository
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.material.title), //
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          actions: [
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.star : Icons.star_border,
                color: _isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: _toggleFavorite,
            ),
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : _buildPdfViewer(),
      ),
    );
  }

  Widget _buildPdfViewer() {
    if (_finalPathToDisplay == null) {
      return const Center(child: Text('لا يوجد ملف للعرض'));
    }

    try {
      if (_finalPathToDisplay!.startsWith('http://') || _finalPathToDisplay!.startsWith('https://')) {
        return SfPdfViewer.network(
          _finalPathToDisplay!,
          key: _pdfViewerKey,
          controller: _pdfController,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          onPageChanged: (PdfPageChangedDetails details) {
            // هنا يمكنك استدعاء GetX Controller لتحديث آخر صفحة
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            setState(() {
              _errorMessage = 'فشل في تحميل الملف: ${details.error}';
            });
          },
        );
      } else if (_finalPathToDisplay!.startsWith('assets/')) {
        return SfPdfViewer.asset(
          _finalPathToDisplay!,
          key: _pdfViewerKey,
          controller: _pdfController,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          onPageChanged: (PdfPageChangedDetails details) {
            // هنا يمكنك استدعاء GetX Controller لتحديث آخر صفحة
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            setState(() {
              _errorMessage = 'فشل في تحميل الملف: ${details.error}';
            });
          },
        );
      } else {
        // يفترض أنه مسار ملف محلي تم تنزيله
        return SfPdfViewer.file(
          File(_finalPathToDisplay!),
          key: _pdfViewerKey,
          controller: _pdfController,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          onPageChanged: (PdfPageChangedDetails details) {
            // هنا يمكنك استدعاء GetX Controller لتحديث آخر صفحة
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            setState(() {
              _errorMessage = 'فشل في تحميل الملف: ${details.error}';
            });
          },
        );
      }
    } catch (e) {
      return Center(child: Text('خطأ في عرض الملف: $e'));
    }
  }
}