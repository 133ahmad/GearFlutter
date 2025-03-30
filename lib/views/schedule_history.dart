import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/scheduleHistory_controller.dart';
import 'package:gear/models/schedule_model.dart';

class ScheduleHistoryScreen extends StatelessWidget {
  final ScheduleHistoryController scheduleController = Get.put(ScheduleHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule History & Upcoming')),
      body: Obx(() {
        if (scheduleController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (scheduleController.schedules.isEmpty) {
          return Center(child: Text('No schedules available.'));
        }
        return ListView.builder(
          itemCount: scheduleController.schedules.length,
          itemBuilder: (context, index) {
            Schedule schedule = scheduleController.schedules[index];
            return ListTile(
              leading: Icon(
                schedule.isUpcoming ? Icons.schedule : Icons.check_circle,
                color: schedule.isUpcoming ? Colors.orange : Colors.green,
              ),
              title: Text(schedule.title),
              subtitle: Text(schedule.dateTime),
              trailing: Text(schedule.isUpcoming ? 'Upcoming' : 'Completed'),
            );
          },
        );
      }),
    );
  }
}
