import 'package:get/get.dart';
import 'package:gear/models/schedule_model.dart';

class ScheduleHistoryController extends GetxController {
  var schedules = <Schedule>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchSchedules();
    super.onInit();
  }

  void fetchSchedules() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simulate API call
    schedules.assignAll([
      Schedule(title: "Brake Repair", dateTime: "2025-04-10", isUpcoming: true),
      Schedule(title: "Oil Change", dateTime: "2025-03-25", isUpcoming: false),
    ]);
    isLoading.value = false;
  }
}
