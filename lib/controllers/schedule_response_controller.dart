import 'package:get/get.dart';

class ScheduleController extends GetxController {
  var schedule = <Map<String, String>>[].obs; // Observable list of scheduled requests

  // Add a service request to the schedule
  void addToSchedule({
    required String customerName,
    required String carDetails,
    required String issue,
    required String response,
  }) {
    schedule.add({
      'customerName': customerName,
      'carDetails': carDetails,
      'issue': issue,
      'response': response,
      'status': 'Scheduled', // Default status
    });
  }

  // Mark an appointment as done
  void markAsDone(int index) {
    if (index >= 0 && index < schedule.length) {
      schedule[index]['status'] = 'Completed'; // Update status to "Completed"
      schedule.refresh(); // Refresh the list to update the UI
    }
  }
}