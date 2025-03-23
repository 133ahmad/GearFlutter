import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  var hasLocationPermission = false.obs;
  var currentLocation = ''.obs;

  // Request location permission
  Future<void> requestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Location Service', 'Please enable location services.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Location Permission', 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Location Permission', 'Location permissions are permanently denied.');
      return;
    }

    // Permission granted
    hasLocationPermission.value = true;
    await _getCurrentLocation();
  }

  // Fetch the current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      currentLocation.value = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch location: $e');
    }
  }
}