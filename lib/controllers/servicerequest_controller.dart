import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gear/models/ServiceType_model.dart';
import 'package:gear/models/Mechanic.dart'; // Create this model if you don't have it
import 'package:gear/models/ServiceRequest_model.dart';

class ServiceRequestController extends GetxController {
  // Form data
  var description = ''.obs;
  var serviceType = 1.obs;
  var appointmentTime = DateTime.now().obs;
  var selectedMechanic = 1.obs;

  // Lists from API
  var serviceTypes = <ServiceType>[].obs;
  var mechanics = <Mechanic>[].obs;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Loading flags
  var isLoadingServiceTypes = false.obs;
  var isLoadingMechanics = false.obs;

  // Fetch service types
  Future<void> fetchServiceTypes() async {
    isLoadingServiceTypes.value = true;
    try {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/service-types'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        serviceTypes.value = (data as List).map((e) => ServiceType.fromJson(e)).toList();
        if (serviceTypes.isNotEmpty) {
          serviceType.value = serviceTypes.first.id;
        }
      } else {
        Get.snackbar('Error', 'Failed to load service types');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while fetching service types');
    } finally {
      isLoadingServiceTypes.value = false;
    }
  }

  // Fetch mechanics
  Future<void> fetchMechanics() async {
    isLoadingMechanics.value = true;
    try {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/mechanics'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        mechanics.value = (data as List).map((e) => Mechanic.fromJson(e)).toList();
        if (mechanics.isNotEmpty) {
          selectedMechanic.value = mechanics.first.id;
        }
      } else {
        Get.snackbar('Error', 'Failed to load mechanics');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while fetching mechanics');
    } finally {
      isLoadingMechanics.value = false;
    }
  }

  // Submit service request
  Future<void> submitServiceRequest() async {
    if (formKey.currentState!.validate()) {
      var url = Uri.parse('http:///api/service-requests');

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': description.value,
          'service_type_id': serviceType.value,
          'status': 'pending',
          'appointment_time': appointmentTime.value.toIso8601String(),
          'customer_id': 1, // Replace with dynamic ID if needed
          'mechanic_id': selectedMechanic.value,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Service request submitted successfully');
      } else {
        Get.snackbar('Error', 'Failed to submit service request');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchServiceTypes();
    fetchMechanics();
  }
}
