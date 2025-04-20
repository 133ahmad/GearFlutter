import 'package:get/get.dart';
import 'package:gear/models/job_model.dart';
import 'package:gear/models/mechanic.dart';
import 'package:gear/services/mechanic_service.dart';

class MechanicController extends GetxController {
  final MechanicService mechanicService = Get.find<MechanicService>();

  var mechanic = Rxn<Mechanic>();
  var assignedJobs = <Job>[].obs;
  var isLoading = false.obs;
  var error = Rxn<String>();

  // Fetch mechanic profile
  Future<void> fetchMechanicProfile(int id) async {
    try {
      isLoading(true);
      error(null);
      mechanic.value = await mechanicService.getMechanicProfile(id);
    } catch (e) {
      error('Failed to load mechanic profile');
      print('Error fetching mechanic profile: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Fetch assigned jobs
  Future<void> fetchAssignedJobs(int mechanicId) async {
    try {
      isLoading(true);
      error(null);
      assignedJobs.value = await mechanicService.getAssignedJobs(mechanicId);
    } catch (e) {
      error('Failed to load assigned jobs');
      print('Error fetching assigned jobs: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Update mechanic availability
  Future<void> updateMechanicAvailability(int id, String availability) async {
    try {
      isLoading(true);
      error(null);
      await mechanicService.updateAvailability(id, availability);
      // Refresh profile after update
      await fetchMechanicProfile(id);
    } catch (e) {
      error('Failed to update availability');
      print('Error updating mechanic availability: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  // Update job status
  Future<void> updateJobStatus(int jobId, String newStatus) async {
    try {
      isLoading(true);
      error(null);
      await mechanicService.updateJobStatus(jobId, newStatus);

      // Update the local list efficiently
      final index = assignedJobs.indexWhere((job) => job.id == jobId);
      if (index != -1) {
        assignedJobs[index] = assignedJobs[index].copyWith(status: newStatus);
        assignedJobs.refresh();
      }
    } catch (e) {
      error('Failed to update job status');
      print('Error updating job status: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}