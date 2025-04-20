import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  var profileImage = ''.obs;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;

  final String baseUrl = 'http://192.168.0.100:8000/api'; // Your API base URL
  final GetStorage _storage = GetStorage();
  late int userId;

  @override
  void onInit() {
    super.onInit();
    userId = _storage.read('userId'); // Get user ID from local storage or preferences
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();

    // Fetch the profile data when the controller is initialized
    fetchProfile();
  }

  // Fetch the profile data from the Laravel API
  Future<void> fetchProfile() async {
    final token = _storage.read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/customer/profile/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      phoneController.text = data['phone'] ?? '';
      cityController.text = data['location'] ?? '';
    } else {
      Get.snackbar('Error', 'Failed to load profile');
    }
  }

  // Update the profile data via the API
  Future<void> updateProfile() async {
    final token = _storage.read('token');
    final data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'location': cityController.text,
    };

    final response = await http.put(
      Uri.parse('$baseUrl/customer/profile/edit/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final updatedData = json.decode(response.body);
      Get.snackbar('Success', 'Profile updated successfully');
      // Optionally update the storage with the new profile data
      _storage.write('name', updatedData['name']);
      _storage.write('email', updatedData['email']);
      _storage.write('phone', updatedData['phone']);
      _storage.write('city', updatedData['location']);
    } else {
      Get.snackbar('Error', 'Failed to update profile');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
