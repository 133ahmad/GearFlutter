import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  final Location _location = Location();

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString currentLocation = 'Unknown'.obs;
  RxBool hasLocationPermission = false.obs;
  RxBool isLocationLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchLocation() async {
    try {
      isLocationLoading.value = true;
      errorMessage.value = '';

      // Check if location service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          errorMessage.value = 'Location services are disabled';
          return;
        }
      }

      // Check location permission
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied ||
          permissionGranted == PermissionStatus.deniedForever) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          hasLocationPermission.value = false;
          errorMessage.value = 'Location permission denied';
          return;
        }
      }

      hasLocationPermission.value = true;
      final locationData = await _location.getLocation();

      // Update location data
      latitude.value = locationData.latitude ?? 0.0;
      longitude.value = locationData.longitude ?? 0.0;
      currentLocation.value = 'Lat: ${latitude.value}, Long: ${longitude.value}';

    } catch (e) {
      errorMessage.value = 'Could not fetch location: ${e.toString()}';
      Get.log("Location error: $e");
    } finally {
      isLocationLoading.value = false;
    }
  }
}