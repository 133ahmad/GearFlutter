import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/scheduleHistory_contoller.dart';
import 'package:gear/models/Schedule_model.dart';

class ScheduleHistoryScreen extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule History & Upcoming')),
      body: Obx(() {
        if (scheduleController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
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