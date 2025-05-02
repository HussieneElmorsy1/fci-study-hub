import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fci_app_new/app_pages/app_routes.dart';
import 'package:fci_app_new/presentation/controllers/add_event_controller.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddEventController controller = Get.put(AddEventController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => Get.offAllNamed(AppRoutes.MAIN_HOME_SCREEN),
        ),
        title: const Text('إضافة حدث'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: controller.addEvent,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'اسم الحدث',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.eventName.value = value,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'الوصف',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.eventDescription.value = value,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(() => OutlinedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            controller.startDate.value = DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        child: Text(controller.startDate.value.isEmpty
                            ? 'من'
                            : controller.startDate.value),
                      )),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => OutlinedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            controller.endDate.value = DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        child: Text(controller.endDate.value.isEmpty
                            ? 'إلى'
                            : controller.endDate.value),
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: controller.addEvent,
                child: const Text('إضافة الحدث'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}