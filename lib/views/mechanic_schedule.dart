import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/schedule_response_controller.dart';

class MechanicScheduleScreen extends StatelessWidget {
  final ScheduleResponseController scheduleController = Get.put(ScheduleResponseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule & Availability'),
      ),
      body: Obx(() {
        if (scheduleController.schedule.isEmpty) {
          return Center(
            child: Text('No scheduled requests.'),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: scheduleController.schedule.length,
          itemBuilder: (context, index) {
            final request = scheduleController.schedule[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(request['customerName'] ?? 'Unknown'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Car: ${request['carDetails'] ?? "N/A"}'),
                    Text('Issue: ${request['issue'] ?? "N/A"}'),
                    Text('Response: ${request['response'] ?? "No response"}'),
                    Text('Status: ${request['status'] ?? "Pending"}'),
                  ],
                ),
                trailing: request['status'] == 'Scheduled'
                    ? ElevatedButton(
                  onPressed: () {
                    scheduleController.markAsDone(index);
                  },
                  child: Text('Done'),
                )
                    : Text(
                  'Completed',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
