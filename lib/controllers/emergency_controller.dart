import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:gear/utils/api_constants.dart'; // Adjust import as needed

class EmergencyRequestController extends GetxController {
  final TextEditingController detailsController = TextEditingController();
  var currentLocation = ''.obs;

  final api = ApiConstants();

  // Get user location
  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Error", "Location services are disabled.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
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
  Future<void> submitEmergencyRequest(String token, int mechanicId) async {
    String description = detailsController.text.trim();

    if (description.isEmpty) {
      Get.snackbar('Error', 'Please enter emergency details!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      final now = DateTime.now();
      String formattedDate = "${now.day}/${now.month}/${now.year}";

      var response = await http.post(
        Uri.parse('$ApiConstants./customer/emergency-request/store'), // ✅ fixed here
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'description': description,
          'mechanics': mechanicId,
          'responseTime': formattedDate,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Emergency request sent successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        detailsController.clear();
      } else {
        var error = jsonDecode(response.body);
        Get.snackbar('Error', error['error'] ?? 'Something went wrong',
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
