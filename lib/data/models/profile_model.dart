// lib/data/models/profile_model.dart
import 'package:get/get.dart'; // Still for '.tr' if used for translation

class ProfileModel {
  final String email;
  final String name;
  final String gender;
  final String collage;
  final String university;
  final String level;
  final String major;
  final double gpa;
  final String universityId; // This will now map to the 'id' from API response

  ProfileModel({
    required this.email,
    required this.name,
    required this.gender,
    required this.collage,
    required this.university,
    required this.level,
    required this.major,
    required this.gpa,
    required this.universityId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Access the nested 'userData' object
    final userData = json['userData'] as Map<String, dynamic>?;

    // Provide default values if userData is null or fields are missing
    return ProfileModel(
      email: userData?['email'] ?? 'default@example.com',
      name: userData?['name'] ?? 'N/A'.tr,
      gender: userData?['gender'] ?? 'N/A'.tr,
      collage: userData?['collage'] ?? 'N/A'.tr,
      university: userData?['university'] ?? 'N/A'.tr,
      level: userData?['level']?.toString() ?? 'N/A'.tr, // Ensure it's a string, API sends "4"
      major: userData?['major'] ?? 'N/A'.tr,
      // Parse 'GPA' string to double. Handle null or invalid format.
      gpa: double.tryParse(userData?['GPA'] ?? '') ?? 0.0,
      // Map API's 'id' to universityId in ProfileModel
      universityId: userData?['id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'collage': collage,
      'university': university,
      'level': level,
      'major': major,
      'gpa': gpa,
      'universityId': universityId, // This would be 'id' if sending to API
    };
  }
}