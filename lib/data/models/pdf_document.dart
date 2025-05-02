class PdfDocument {
  final String id;
  final String title;
  final String url;
  final DateTime createdAt;
  final String? description;
  final String category;
  final bool isDownloaded;
  final bool isFavorite;
  final DateTime? lastRead;
  final int? lastPage; // ← آخر صفحة تم الوقوف عندها

  PdfDocument({
    required this.id,
    required this.title,
    required this.url,
    required this.createdAt,
    this.description,
    required this.category,
    this.isDownloaded = false,
    this.isFavorite = false,
    this.lastRead,
    this.lastPage,
  });

  PdfDocument copyWith({
    String? id,
    String? title,
    String? url,
    DateTime? createdAt,
    String? description,
    String? category,
    bool? isDownloaded,
    bool? isFavorite,
    DateTime? lastRead,
    int? lastPage, // ← أضفناها هنا
  }) {
    return PdfDocument(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      category: category ?? this.category,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isFavorite: isFavorite ?? this.isFavorite,
      lastRead: lastRead ?? this.lastRead,
      lastPage: lastPage ?? this.lastPage, // ← أضفناها هنا
    );
  }
}
