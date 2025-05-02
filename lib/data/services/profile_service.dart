import '../models/profile_model.dart';

class ApiProfileService {
  // في المرحلة الأولى نستخدم بيانات محلية
  // لاحقاً يمكن استبدالها بطلب HTTP حقيقي
  Future<ProfileModel> fetchProfileData() async {
    // محاكاة انتظار الشبكة
    await Future.delayed(Duration(seconds: 1));

    // حالياً نرجع البيانات الافتراضية
    // في المستقبل يمكن استبدال هذا الجزء بطلب API حقيقي
    return ProfileModel();

    // عندما يصبح API جاهزاً، يمكنك استخدام:
    // final response = await http.get(Uri.parse('$baseUrl/profile'));
    // if (response.statusCode == 200) {
    //   return ProfileModel.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Failed to load profile data');
    // }
  }
}
