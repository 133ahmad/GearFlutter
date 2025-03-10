import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceRequestController extends GetxController {
  // Rx variables to store the form data
  var description = ''.obs;
  var serviceType = 'Basic Repair'.obs;
  var contactNumber = ''.obs;
  var preferredTime = 'Morning'.obs;
  var scheduledDate = DateTime.now().obs;

  // List of available service types
  List<String> serviceTypes = ['Basic Repair', 'Engine Work', 'Tire Replacement', 'AC Repair'];

  // Form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Method to submit the service request to the backend
  Future<void> submitServiceRequest() async {
    if (formKey.currentState!.validate()) {
      var url = Uri.parse('https://your-laravel-api.com/api/service-request'); // Your Laravel endpoint

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': description.value,
          'service_type': serviceType.value,
          'contact_number': contactNumber.value,
          'preferred_time': preferredTime.value,
          'scheduled_date': scheduledDate.value.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        // Successfully submitted the request
        Get.snackbar('Success', 'Service request submitted successfully');
      } else {
        // Handle errors
        Get.snackbar('Error', 'Failed to submit service request');
      }
    }
  }
}
