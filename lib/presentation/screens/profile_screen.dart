import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/data/models/profile_model.dart';
import 'package:fci_app_new/presentation/widgets/horizontal_line.dart';
import 'package:fci_app_new/presentation/widgets/profile_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> futureProfile;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  void loadProfileData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        futureProfile = _fetchUserProfile(user.uid);
      });
    } else {
      setState(() {
        futureProfile = Future.value(ProfileModel());
      });
    }
  }

  Future<ProfileModel> _fetchUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('students').doc(userId).get();
      if (doc.exists) {
        return ProfileModel.fromJson(doc.data()!);
      }
      return ProfileModel.loadProfile();
    } catch (e) {
      log("Error fetching profile: $e");
      return ProfileModel.loadProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('4.1'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadProfileData,
            tooltip: '4.2'.tr,
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.toNamed(AppRoutes.HOME_SCREEN),
        ),
      ),
      body: FutureBuilder<ProfileModel>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('4.3'.tr),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: loadProfileData,
                    child: Text('4.4'.tr),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return buildProfileView(snapshot.data!);
          } else {
            return Center(child: Text('4.5'.tr));
          }
        },
      ),
      extendBody: true,
    );
  }

  Widget buildProfileView(ProfileModel profile) {
    return RefreshIndicator(
      onRefresh: () async {
        loadProfileData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              HorizontalLine(color: Theme.of(context).dividerColor),
              ProfileItem(title: '4.6'.tr, value: profile.name),
              ProfileItem(title: '4.7'.tr, value: profile.gender),
              ProfileItem(title: '4.8'.tr, value: profile.college),
              ProfileItem(title: '4.9'.tr, value: profile.university),
              ProfileItem(title: '4.10'.tr, value: profile.level),
              ProfileItem(title: '4.11'.tr, value: profile.specialization),
              ProfileItem(title: '4.12'.tr, value: profile.degree),
              ProfileItem(title: '4.13'.tr, value: profile.studentId),
              ProfileItem(
                title: '4.14'.tr,
                value: profile.gpa.toStringAsFixed(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
