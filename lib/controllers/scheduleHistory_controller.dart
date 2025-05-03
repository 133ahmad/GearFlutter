import 'package:get/get.dart';
import 'package:gear/models/schedule_model.dart';
import 'package:gear/services/api_service.dart';

class ScheduleHistoryController extends GetxController {
  final schedules = <Schedule>[].obs;
  final isLoading = true.obs;
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    fetchSchedules();
    super.onInit();
  }

  Future<void> fetchSchedules() async {
    try {
      isLoading(true);
      final response = await _apiService.get('/schedules');

      if (response.data is List) {
        final schedulesList = (response.data as List)
            .map((json) => Schedule.fromJson(json as Map<String, dynamic>))
            .where((schedule) => schedule.id != null) // Filter out invalid entries
            .toList();
        schedules.assignAll(schedulesList);
      } else {
        throw Exception('Expected list but got ${response.data.runtimeType}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load schedules: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelSchedule(String scheduleId) async {
    try {
      isLoading(true);
      final response = await _apiService.delete('/schedules/$scheduleId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        schedules.removeWhere((s) => s.id == scheduleId);
        Get.snackbar('Success', 'Appointment cancelled');
      } else {
        throw Exception('Failed with status ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel appointment: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}