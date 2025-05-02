import 'dart:developer';

import 'package:fci_app_new/data/models/status_model.dart';
import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  final List<Status> statuses;

  const StatusBar({super.key, required this.statuses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // ارتفاع شريط الحالة
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          final status = statuses[index];
          return _buildStatusCircle(status);
        },
      ),
    );
  }

  Widget _buildStatusCircle(Status status) {
    return GestureDetector(
      onTap: () {
        log("عر1ض حالة: ${status.username}");
      },
      child: Container(
        width: 75,
        height: 75,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              padding: const EdgeInsets.all(2), // سماكة الحد
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: status.isViewed ? Colors.grey : Colors.green, // لون الحد
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(status.imageAsset ??
                    'assets/images/home_screen/Ellipse_25.png'),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
