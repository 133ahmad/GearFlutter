import 'package:get/get.dart';
import 'package:gear/models/job_model.dart'; // Assuming you have a Job model

class MechanicController extends GetxController {
  // List of assigned jobs
  var assignedJobs = <Job>[].obs;

  // Fetch assigned jobs (example method)
  void fetchAssignedJobs() {
    // Simulate fetching jobs from an API or database
    assignedJobs.assignAll([
      Job(id: '1', carMake: 'Toyota', carModel: 'Corolla', issue: 'Engine Check'),
      Job(id: '2', carMake: 'Honda', carModel: 'Civic', issue: 'Brake Repair'),
    ]);
  }

  // Update job status (example method)
  void updateJobStatus(String jobId, String status) {
    final job = assignedJobs.firstWhere((job) => job.id == jobId);
    job.status = status;
    assignedJobs.refresh(); // Refresh the list to update the UI
  }

  // Settings related logic
  var notificationEnabled = true.obs;
  var darkModeEnabled = false.obs;

  void toggleNotification(bool value) {
    notificationEnabled.value = value;
  }

  void toggleDarkMode(bool value) {
    darkModeEnabled.value = value;
  }
}