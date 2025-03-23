import 'package:get/get.dart';
import 'package:gear/models/mechanic_schedule_model.dart'; // Assuming you have a Schedule model

class MechanicScheduleController extends GetxController {
  // List of scheduled jobs
  var scheduledJobs = <Schedule>[].obs;

  // Mechanic's availability
  var isAvailable = true.obs;

  // Fetch scheduled jobs (example method)
  void fetchScheduledJobs() {
    // Simulate fetching jobs from an API or database
    scheduledJobs.assignAll([
      Schedule(
        id: '1',
        date: '2023-10-25',
        time: '10:00 AM',
        carMake: 'Toyota',
        carModel: 'Corolla',
        issue: 'Oil Change',
      ),
      Schedule(
        id: '2',
        date: '2023-10-26',
        time: '02:00 PM',
        carMake: 'Honda',
        carModel: 'Civic',
        issue: 'Brake Repair',
      ),
    ]);
  }

  // Toggle availability
  void toggleAvailability(bool value) {
    isAvailable.value = value;
  }

  // Add a new schedule (example method)
  void addSchedule(Schedule newSchedule) {
    scheduledJobs.add(newSchedule);
    scheduledJobs.refresh(); // Refresh the list to update the UI
  }

  // Remove a schedule (example method)
  void removeSchedule(String scheduleId) {
    scheduledJobs.removeWhere((schedule) => schedule.id == scheduleId);
    scheduledJobs.refresh(); // Refresh the list to update the UI
  }
}