import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/emergency_controller.dart';
class EmergencyRequestScreen extends StatelessWidget {
  final EmergencyRequestController controller = Get.put(EmergencyRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Request'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Describe Your Emergency',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Displaying the live location
            Obx(() => TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Location (Auto-Fetched)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
                hintText: controller.currentLocation.value.isEmpty
                    ? 'Fetching location...'
                    : controller.currentLocation.value,
              ),
            )),
            SizedBox(height: 10),

            // Emergency details input
            TextField(
              controller: controller.detailsController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Details',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.submitEmergencyRequest(1), // Pass user ID dynamically
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Submit Request', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
