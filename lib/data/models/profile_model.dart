import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fci_app_new/core/utils/string_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileModel {
  final String email;
  final String name;
  final String gender;
  final String college;
  final String university;
  final String level;
  final String specialization;
  final String degree;
  final String studentId;
  final double gpa;

  ProfileModel({
    String? email,
    String? name,
    String? gender,
    String? college,
    String? university,
    String? level,
    String? specialization,
    String? degree,
    String? studentId,
    double? gpa,
  })  : email = email ?? 'UGS.141170@ci.suez.edu.eg',
        name = name ?? '4.15'.tr,
        gender = gender ?? '4.16'.tr,
        college = college ?? '4.17'.tr,
        university = university ?? '4.18'.tr,
        level = level ?? '4.19'.tr,
        specialization = specialization ?? '4.20'.tr,
        degree = degree ?? '4.21'.tr,
        studentId = studentId ?? '124765',
        gpa = gpa ?? 4.5;

  static Future<ProfileModel> loadProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final prefs = await SharedPreferences.getInstance();

      String? email = user?.email ?? prefs.getString('userEmail');
      String? name = user?.displayName;
      String studentId = '';

      if (user != null) {
        if (user.providerData.any((info) => info.providerId == 'microsoft.com')) {
          studentId = extractStudentId(email ?? '');
        } else {
          studentId = prefs.getString('studentId') ?? '124765';
        }

        final doc = await FirebaseFirestore.instance
            .collection('students')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          return ProfileModel.fromJson({
            ...doc.data()!,
            'email': email ?? doc.data()!['email'],
            'name': name ?? doc.data()!['name'],
            'studentId': studentId,
          });
        }
      }

      return ProfileModel(
        email: email,
        name: name,
        studentId: studentId,
      );
    } catch (e) {
      log('Error loading profile: $e');
      return ProfileModel();
    }
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      email: json['email'] ?? 'UGS.141170@ci.suez.edu.eg',
      name: json['name'] ?? '4.15'.tr,
      gender: json['gender'] ?? '4.16'.tr,
      college: json['college'] ?? '4.17'.tr,
      university: json['university'] ?? '4.18'.tr,
      level: json['level'] ?? '4.19'.tr,
      specialization: json['specialization'] ?? '4.20'.tr,
      degree: json['degree'] ?? '4.21'.tr,
      studentId: json['studentId'] ?? '124765',
      gpa: json['gpa']?.toDouble() ?? 4.5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'college': college,
      'university': university,
      'level': level,
      'specialization': specialization,
      'degree': degree,
      'studentId': studentId,
      'gpa': gpa,
    };
  }
}