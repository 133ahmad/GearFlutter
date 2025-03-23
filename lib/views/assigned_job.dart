import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/mechanic_controller.dart';
import 'package:gear/models/job_model.dart';

class AssignedJobsScreen extends StatelessWidget {
  final MechanicController mechanicController = Get.put(MechanicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Jobs'),
      ),
      body: Obx(() {
        if (mechanicController.assignedJobs.isEmpty) {
          return Center(
            child: Text('No jobs assigned yet.'),
          );
        }
        return ListView.builder(
          itemCount: mechanicController.assignedJobs.length,
          itemBuilder: (context, index) {
            final job = mechanicController.assignedJobs[index];
            return ListTile(
              title: Text('${job.carMake} ${job.carModel}'),
              subtitle: Text('Issue: ${job.issue}'),
              trailing: DropdownButton<String>(
                value: job.status,
                onChanged: (newStatus) {
                  mechanicController.updateJobStatus(job.id, newStatus!);
                },
                items: <String>['Pending', 'In Progress', 'Completed']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          },
        );
      }),
    );
  }
}