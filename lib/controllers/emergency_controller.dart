import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class EmergencyRequestController extends GetxController {
  final TextEditingController detailsController = TextEditingController();
  var currentLocation = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location services are disabled.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Check for permissions
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

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation.value = "${position.latitude}, ${position.longitude}";
  }

  Future<void> submitEmergencyRequest(int userId) async {
    String details = detailsController.text.trim();
    if (currentLocation.value.isEmpty || details.isEmpty) {
      Get.snackbar('Error', 'Please enter emergency details!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://your-laravel-api.com/api/emergency-requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'location': currentLocation.value,
          'details': details,
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
}
