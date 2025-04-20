import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  var admin = {}.obs;

  // Register admin
  Future<void> registerAdmin() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String passwordConfirmation = passwordConfirmationController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != passwordConfirmation) {
      Get.snackbar('Error', 'Password and confirmation do not match!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://your-laravel-api-url.com/api/admin/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Admin registered successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        passwordConfirmationController.clear();
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

  // Fetch admin profile
  Future<void> fetchProfile(int adminId) async {
    try {
      var response = await http.get(
        Uri.parse('http://your-laravel-api-url.com/api/admin/$adminId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        admin.value = jsonDecode(response.body);
      } else {
        Get.snackbar('Error', 'Failed to fetch profile',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to connect to server!',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Update profile
  Future<void> updateProfile(int adminId) async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields!',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      var response = await http.put(
        Uri.parse('http://your-laravel-api-url.com/api/admin/$adminId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully!',
            backgroundColor: Colors.green, colorText: Colors.white);
        fetchProfile(adminId);  // Refresh profile data
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
