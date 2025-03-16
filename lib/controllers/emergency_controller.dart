import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmergencyRequestController extends GetxController {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  Future<void> submitEmergencyRequest(int userId) async {
    String location = locationController.text.trim();
    String details = detailsController.text.trim();

    if (location.isEmpty || details.isEmpty) {
      Get.snackbar('Error', 'Please enter location and details!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://your-laravel-api.com/api/emergency-requests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'location': location,
          'details': details,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Emergency request sent successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        locationController.clear();
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
