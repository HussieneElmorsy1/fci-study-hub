import 'dart:io';
import 'package:fci_app_new/core/utils/pdf_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../models/pdf_document.dart';
import '../models/document_collection.dart';

class PdfService {
  // Fetch documents from API or mock data
  Future<List<DocumentCollection>> fetchDocumentCollections() async {
    // In a real app, this would be an API call
    // For demo purposes, we'll return mock data
    await Future.delayed(Duration(milliseconds: 800)); // Simulate network delay
    
    return [
      DocumentCollection(
        id: 'lectures',
        title: 'محاضرات',
        category: 'محاضرة',
        documents: PdfData.getLectureDocuments(),
        createdAt: DateTime.now(),
      ),
      DocumentCollection(
        id: 'sections',
        title: 'سكشن',
        category: 'سكشن',
        documents: PdfData.getSectionDocuments(),
        createdAt: DateTime.now(),
      ),
      DocumentCollection(
        id: 'videos',
        title: 'فيديو',
        category: 'فيديو',
        documents: [],
        createdAt: DateTime.now(),
      ),
      DocumentCollection(
        id: 'homework',
        title: 'الواجبات',
        category: 'الواجبات',
        documents: PdfData.getHomeworkDocuments(),
        createdAt: DateTime.now(),
      ),
    ];
  }

  // Download PDF document
  Future<String> downloadDocument(PdfDocument document) async {
    try {
      final response = await http.get(Uri.parse(document.url));
      
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${document.id}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        throw Exception('Failed to download document: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error downloading document: $e');
    }
  }

  // Check if document exists locally
  Future<bool> documentExists(String documentId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$documentId.pdf';
      return await File(filePath).exists();
    } catch (e) {
      return false;
    }
  }

  // Get local path for document
  Future<String?> getLocalPathForDocument(String documentId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$documentId.pdf';
      final exists = await File(filePath).exists();
      return exists ? filePath : null;
    } catch (e) {
      return null;
    }
  }
}