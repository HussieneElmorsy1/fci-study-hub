import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../data/models/pdf_document.dart';
import '../../data/providers/document_provider.dart';

class PdfViewerScreen extends StatefulWidget {
  final PdfDocument document;
  final String collectionId;

  const PdfViewerScreen({
    Key? key,
    required this.document,
    required this.collectionId,
  }) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? _localPath;
  bool _isLoading = true;
  String _errorMessage = '';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfController;
  late bool _isFavorite;
  late bool _isDownloaded;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.document.isFavorite;
    _isDownloaded = widget.document.isDownloaded;
    _pdfController = PdfViewerController();
    _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      if (widget.document.url.startsWith('http')) {
        final response = await http.get(Uri.parse(widget.document.url));

        if (response.statusCode == 200) {
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/${widget.document.title}.pdf';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

          if (!_isDownloaded) {
            Provider.of<DocumentProvider>(context, listen: false)
                .markAsDownloaded(widget.collectionId, widget.document.id);
            _isDownloaded = true;
          }

          setState(() {
            _localPath = filePath;
            _isLoading = false;

            // بعد تحميل الملف، روح للصفحة الأخيرة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (widget.document.lastPage != null &&
                  widget.document.lastPage! > 0) {
                _pdfController.jumpToPage(widget.document.lastPage!);
              }

              Provider.of<DocumentProvider>(context, listen: false)
                  .updateLastRead(
                widget.collectionId,
                widget.document.id,
              );
            });
          });
        } else {
          setState(() {
            _errorMessage = 'فشل تحميل الملف: ${response.statusCode}';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _localPath = widget.document.url;
          _isLoading = false;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (widget.document.lastPage != null &&
                widget.document.lastPage! > 0) {
              _pdfController.jumpToPage(widget.document.lastPage!);
            }

            Provider.of<DocumentProvider>(context, listen: false)
                .updateLastRead(
              widget.collectionId,
              widget.document.id,
            );
          });
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ في تحميل الملف: $e';
        _isLoading = false;
      });
    }
  }

  void _toggleFavorite() {
    Provider.of<DocumentProvider>(context, listen: false)
        .toggleFavorite(widget.collectionId, widget.document.id);
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
          title: Text(widget.document.title),
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
    if (_localPath == null) {
      return const Center(child: Text('لا يوجد ملف للعرض'));
    }

    try {
      final docProvider = Provider.of<DocumentProvider>(context, listen: false);

      if (_localPath!.startsWith('')) {
        return SfPdfViewer.asset(
          _localPath!,
          key: _pdfViewerKey,
          controller: _pdfController,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          onPageChanged: (PdfPageChangedDetails details) {
            docProvider.updateLastPage(
              widget.collectionId,
              widget.document.id,
              details.newPageNumber,
            );
          },
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            setState(() {
              _errorMessage = 'فشل في تحميل الملف: ${details.error}';
            });
          },
        );
      } else {
        return SfPdfViewer.file(
          File(_localPath!),
          key: _pdfViewerKey,
          controller: _pdfController,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          onPageChanged: (PdfPageChangedDetails details) {
            docProvider.updateLastPage(
              widget.collectionId,
              widget.document.id,
              details.newPageNumber,
            );
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
