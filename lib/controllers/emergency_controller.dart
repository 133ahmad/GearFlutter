import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class EmergencyRequestController extends GetxController {
  final TextEditingController detailsController = TextEditingController(); // Added controller
  var currentLocation = ''.obs;

  // Get current user location
  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location services are disabled.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Error", "Location permission denied.",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Error", "Location permissions are permanently denied.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation.value = "${position.latitude}, ${position.longitude}";
  }

  // Submit emergency request to API
  Future<void> submitEmergencyRequest(int customerId) async {
    String description = detailsController.text.trim();
    if (currentLocation.value.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Please enter emergency details!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://your-laravel-api-url.com/api/emergency-requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': description,
          'location': currentLocation.value,
          'customer_id': customerId,  // Send customer ID dynamically
          'responseTime': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Emergency request sent successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        detailsController.clear();
      } else {
        var errorResponse = jsonDecode(response.body);
        Get.snackbar('Error', errorResponse['message'] ?? 'Something went wrong',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server!',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }
}
