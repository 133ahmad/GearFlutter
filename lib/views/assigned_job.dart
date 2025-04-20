import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/mechanic_controller.dart';
import 'package:gear/models/job_model.dart';
import 'package:gear/models/car_model.dart';
class AssignedJobsScreen extends StatelessWidget {
  final int mechanicId; // Make mechanicId configurable
  final MechanicController mechanicController = Get.find<MechanicController>();

  AssignedJobsScreen({required this.mechanicId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch assigned jobs when the screen is loaded
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      mechanicController.fetchAssignedJobs(mechanicId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Assigned Jobs'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => mechanicController.fetchAssignedJobs(mechanicId),
          ),
        ],
      ),
      body: Obx(() {
        if (mechanicController.error.value != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error loading jobs',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(mechanicController.error.value ?? 'Unknown error'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => mechanicController.fetchAssignedJobs(mechanicId),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (mechanicController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (mechanicController.assignedJobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.assignment, size: 50, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No jobs assigned yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Check back later for new assignments',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await mechanicController.fetchAssignedJobs(mechanicId);
          },
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemCount: mechanicController.assignedJobs.length,
            itemBuilder: (context, index) {
              final job = mechanicController.assignedJobs[index];
              return _buildJobCard(context, job);
            },
          ),
        );
      }),
    );
  }

  Widget _buildJobCard(BuildContext context, Job job) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${job.carMake} ${job.carModel}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(job.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    job.status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Issue: ${job.issue}',
              style: TextStyle(fontSize: 16),
            ),
            if (job.description?.isNotEmpty ?? false) ...[
              SizedBox(height: 8),
              Text(
                'Details: ${job.description}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (job.plateNumber?.isNotEmpty ?? false)
                  Chip(
                    label: Text(job.plateNumber!),
                    backgroundColor: Colors.grey[200],
                  ),
                DropdownButton<String>(
                  value: job.status,
                  underline: Container(),
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String? newStatus) {
                    if (newStatus != null && newStatus != job.status) {
                      _showStatusChangeDialog(context, job, newStatus);
                    }
                  },
                  items: <String>['Pending', 'In Progress', 'Completed']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showStatusChangeDialog(BuildContext context, Job job, String newStatus) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Status Change'),
        content: Text('Change job status from ${job.status} to $newStatus?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              mechanicController.updateJobStatus(job.id, newStatus);
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}