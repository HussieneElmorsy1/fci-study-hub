// lib/domain/repository/lecture_repository.dart
import 'package:fci_app_new/data/models/lecture_time_model.dart'; //

abstract class LectureRepository {
  Future<List<LectureTimeModel>> getAllLectureTimes();
  // يمكن إضافة دوال مجردة هنا لعمليات أخرى (جلب بالـ ID، إنشاء، تحديث، حذف)
  // Future<LectureTimeModel> getLectureTimeById(String id);
  // Future<void> createLectureTime(LectureTimeModel lectureTime);
  // Future<void> updateLectureTime(LectureTimeModel lectureTime);
  // Future<void> deleteLectureTime(String id);
}