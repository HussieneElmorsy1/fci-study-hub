// utils/string_utils.dart

String extractStudentId(String email) {
  try {
    final parts = email.split('@').first.split('.');
    if (parts.length > 1) {
      return parts[1];
    }
    return '';
  } catch (e) {
    return '';
  }
}
