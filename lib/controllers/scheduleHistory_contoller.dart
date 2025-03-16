import 'package:get/get.dart';
import 'package:gear/models/Schedule_model.dart';

class ScheduleController extends GetxController {
  var schedules = <Schedule>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchSchedules();
    super.onInit();
  }

  void fetchSchedules() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate API call
    schedules.value = [
      Schedule(title: 'Oil Change', dateTime: '2025-03-20', isUpcoming: true),
      Schedule(title: 'Brake Inspection', dateTime: '2025-03-10', isUpcoming: false),
    ];
    isLoading.value = false;
  }
}
