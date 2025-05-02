class Status {
  final String username;
  final String? imageAsset;
  bool isViewed; // إذا كانت الحالة مُشاهدة

  Status({
    required this.username,
    required this.imageAsset,
    this.isViewed = false,
  });

  // دالة لتحديث حالة المشاهدة
  void updateStatus(bool viewed) {
    isViewed = viewed;
  }
}
