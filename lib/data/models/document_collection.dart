import 'pdf_document.dart';

class DocumentCollection {
  final String id;
  final String title;
  final String category;
  final List<PdfDocument> documents;
  final DateTime createdAt;
  final String? description;

  DocumentCollection({
    required this.id,
    required this.title,
    required this.category,
    required this.documents,
    required this.createdAt,
    this.description,
  });

  DocumentCollection copyWith({
    String? id,
    String? title,
    String? category,
    List<PdfDocument>? documents,
    DateTime? createdAt,
    String? description,
  }) {
    return DocumentCollection(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      documents: documents ?? this.documents,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
    );
  }
}