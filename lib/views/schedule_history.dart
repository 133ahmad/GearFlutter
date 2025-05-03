import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/scheduleHistory_controller.dart';
import 'package:gear/models/schedule_model.dart';

class ScheduleHistoryScreen extends StatelessWidget {
  final ScheduleHistoryController controller = Get.put(ScheduleHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchSchedules,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.schedules.isEmpty) {
          return const Center(child: Text('No appointments found'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.schedules.length,
          itemBuilder: (context, index) {
            final schedule = controller.schedules[index];
            return _buildScheduleCard(schedule, context); // Pass context here
          },
        );
      }),
    );
  }

  Widget _buildScheduleCard(Schedule schedule, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(
          schedule.statusIcon,
          color: schedule.statusColor,
        ),
        title: Text(
          schedule.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service: ${schedule.serviceType}'),
            Text('Mechanic: ${schedule.mechanicName}'),
            Text('Date: ${schedule.formattedDate}'),
            Text('Time: ${schedule.formattedTime}'),
            if (schedule.isUpcoming)
              Text(
                schedule.timeRemaining,
                style: TextStyle(color: Theme.of(context).primaryColor), // Use context here
              ),
          ],
        ),
        trailing: schedule.isUpcoming
            ? IconButton(
          icon: const Icon(Icons.cancel, color: Colors.red),
          onPressed: () => controller.cancelSchedule(schedule.id),
        )
            : null,
      ),
    );
  }
}
