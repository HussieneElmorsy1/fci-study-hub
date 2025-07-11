// // lib/data/datasources/remote/material_remote_data_source.dart
// import 'dart:developer';
// import 'package:dio/dio.dart'; //
// import 'package:fci_app_new/data/api/api_service.dart'; //
// import 'package:fci_app_new/data/models/material_item_model.dart'; //

// class MaterialRemoteDataSource {
//   final ApiService _apiService; //

//   MaterialRemoteDataSource(this._apiService);

//   /// يجلب قائمة بالمواد (PDFs, Videos, Exams, Books) لمقرر دراسي معين ونوع معين.
//   /// حالياً، هذه الدالة تُرجع بيانات وهمية.
//   /// في المستقبل، سيتم تعديلها لاستدعاء الـ API الحقيقي.
//   Future<List<MaterialItemModel>> getMaterialsByCourseAndType(String courseId, String materialType) async {
//     log('MaterialRemoteDataSource: Attempting to fetch $materialType for course $courseId');
//     try {
//       // ** هنا سيتم دمج استدعاء API حقيقي لاحقاً **
//       // مثال لاستدعاء API افتراضي (عند توفر نقطة نهاية):
//       // final response = await _apiService.get('/materials', queryParameters: {'courseId': courseId, 'type': materialType});
//       // if (response.statusCode == 200) {
//       //   final List<dynamic> materialsJson = response.data['data'] ?? []; // افتراض أن البيانات تحت مفتاح 'data'
//       //   return materialsJson.map((json) => MaterialItemModel.fromJson(json)).toList();
//       // } else {
//       //   throw ApiException(response.statusCode!, response.data.toString());
//       // }

//       // ** في الوقت الحالي: بيانات وهمية **
//       await Future.delayed(const Duration(milliseconds: 500)); // محاكاة لتاخير الشبكة

//       return _getMockMaterials(courseId, materialType); // دالة مساعدة لإنشاء بيانات وهمية
//     } on DioException catch (e) {
//       log('DioException in MaterialRemoteDataSource.getMaterialsByCourseAndType: $e');
//       rethrow;
//     } catch (e) {
//       log('Error in MaterialRemoteDataSource.getMaterialsByCourseAndType: $e');
//       throw Exception('Failed to fetch materials: $e');
//     }
//   }

//   // دالة مساعدة لتوليد بيانات وهمية
//   List<MaterialItemModel> _getMockMaterials(String courseId, String materialType) {
//     List<MaterialItemModel> mockData = [];

//     if (materialType == 'pdfs') {
//       for (int i = 1; i <= 5; i++) {
//         mockData.add(MaterialItemModel(
//           id: '$courseId-pdf-$i',
//           title: 'مقدمة في البرمجة - الأسبوع $i (PDF)',
//           url: 'https://example.com/pdf_week_$i.pdf', // رابط PDF وهمي
//           type: 'pdfs',
//           doctorName: 'د. أحمد علي',
//           courseTitle: 'مقدمة في البرمجة',
//           isDownloaded: i % 2 == 0, // مثال: بعضها تم تنزيله
//           canEdit: true, canDelete: true, // مثال: صلاحيات المدرس
//         ));
//       }
//     } else if (materialType == 'videos') {
//       for (int i = 1; i <= 3; i++) {
//         mockData.add(MaterialItemModel(
//           id: '$courseId-video-$i',
//           title: 'محاضرة البرمجة $i (فيديو)',
//           url: 'https://example.com/video_lecture_$i.mp4', // رابط فيديو وهمي
//           type: 'videos',
//           doctorName: 'د. سارة محمود',
//           courseTitle: 'هياكل البيانات',
//           thumbnailUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF?text=Video+$i',
//           canEdit: false, canDelete: false, // مثال: الطالب لا يمكنه التعديل
//         ));
//       }
//     } else if (materialType == 'books') {
//       mockData.add(MaterialItemModel(
//         id: '$courseId-book-1',
//         title: 'كتاب أساسيات البرمجة',
//         url: 'https://example.com/programming_book.pdf',
//         type: 'books',
//         canEdit: true, canDelete: false,
//       ));
//     } else if (materialType == 'exams') {
//       mockData.add(MaterialItemModel(
//         id: '$courseId-exam-1',
//         title: 'اختبار نصفي (المفاهيم الأساسية)',
//         url: 'https://example.com/midterm_exam.pdf',
//         type: 'exams',
//         canEdit: false, canDelete: true,
//       ));
//     }
//     return mockData;
//   }
// }


// lib/data/datasources/remote/material_remote_data_source.dart
import 'dart:developer';
import 'package:dio/dio.dart'; //
import 'package:fci_app_new/data/api/api_service.dart'; //
import 'package:fci_app_new/data/models/material_item_model.dart'; //

class MaterialRemoteDataSource {
  final ApiService _apiService; //

  MaterialRemoteDataSource(this._apiService);

  Future<List<MaterialItemModel>> getMaterialsByCourseAndType(String courseId, String materialType) async {
    log('MaterialRemoteDataSource: Attempting to fetch $materialType for course $courseId');
    try {
      // ** هنا سيتم دمج استدعاء API حقيقي لاحقاً **
      // final response = await _apiService.get('/materials', queryParameters: {'courseId': courseId, 'type': materialType});
      // if (response.statusCode == 200) {
      //   final List<dynamic> materialsJson = response.data['data'] ?? [];
      //   return materialsJson.map((json) => MaterialItemModel.fromJson(json)).toList();
      // } else {
      //   throw ApiException(response.statusCode!, response.data.toString());
      // }

      // ** في الوقت الحالي: بيانات وهمية تُشير إلى مسارات Assets محلية **
      await Future.delayed(const Duration(milliseconds: 500)); // محاكاة لتاخير الشبكة

      return _getMockMaterials(courseId, materialType); // دالة مساعدة لإنشاء بيانات وهمية
    } on DioException catch (e) {
      log('DioException in MaterialRemoteDataSource.getMaterialsByCourseAndType: $e');
      rethrow;
    } catch (e) {
      log('Error in MaterialRemoteDataSource.getMaterialsByCourseAndType: $e');
      throw Exception('Failed to fetch materials: $e');
    }
  }

  // دالة مساعدة لتوليد بيانات وهمية (تستخدم مسارات Assets)
  List<MaterialItemModel> _getMockMaterials(String courseId, String materialType) {
    List<MaterialItemModel> mockData = [];

    if (materialType == 'pdfs') {
      for (int i = 1; i <= 5; i++) {
        mockData.add(MaterialItemModel(
          id: '$courseId-pdf-$i',
          title: 'مقدمة في البرمجة - الأسبوع $i (PDF)',
          url: 'assets/pdfs/ntroduction_to_Geographic_Information_Systems_9th_Edition.Pdf', // <--- مسار Asset PDF وهمي
          type: 'pdfs',
          doctorName: 'د. أحمد علي',
          courseTitle: 'مقدمة في البرمجة',
          isDownloaded: false, // افتراضياً غير منزّل
          canEdit: true, canDelete: true, // مثال: صلاحيات المدرس
        ));
      }
    } else if (materialType == 'videos') {
      for (int i = 1; i <= 3; i++) {
        mockData.add(MaterialItemModel(
          id: '$courseId-video-$i',
          title: 'محاضرة البرمجة $i (فيديو)',
          url: 'assets/videos/rasol_allah.mp4', // <--- مسار Asset Video وهمي
          type: 'videos',
          doctorName: 'د. سارة محمود',
          courseTitle: 'هياكل البيانات',
          thumbnailUrl: 'assets/dummy/video/dummy_thumbnail.png', // <--- مسار Asset Thumbnail وهمي
          canEdit: false, canDelete: false, // مثال: الطالب لا يمكنه التعديل
        ));
      }
    } else if (materialType == 'books') {
      mockData.add(MaterialItemModel(
        id: '$courseId-book-1',
        title: 'كتاب أساسيات البرمجة',
        url: 'assets/pdfs/ntroduction_to_Geographic_Information_Systems_9th_Edition.Pdf', // <--- مسار Asset Book وهمي
        type: 'books',
        canEdit: true, canDelete: false,
      ));
    } else if (materialType == 'exams') {
      mockData.add(MaterialItemModel(
        id: '$courseId-exam-1',
        title: 'اختبار نصفي (المفاهيم الأساسية)',
        url: 'assets/pdfs/ntroduction_to_Geographic_Information_Systems_9th_Edition.Pdf', // <--- مسار Asset Exam وهمي
        type: 'exams',
        canEdit: false, canDelete: true,
      ));
    }
    return mockData;
  }
}