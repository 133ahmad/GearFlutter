// controllers/login_controller.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController {
  // For Testing: Simulate login without actual backend call
  Future<void> handleLogin(BuildContext context, String phone, String password, String selectedRole) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    // Simulate login success
    Navigator.pushReplacementNamed(context, selectedRole == "Customer" ? '/first' : '/mechanic');
  }

  // Real Implementation: Connect to your backend API for real login
  Future<bool> handleLoginReal(BuildContext context, String phone, String password, String selectedRole) async {
    String apiUrl = "http://127.0.0.1:8000/api/login"; // Replace with your actual API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'phone': phone,
          'password': password,
          'role': selectedRole.toLowerCase(),
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          print("Login successful!");
          // Navigate based on role
          if (selectedRole == "Customer") {
            Navigator.pushReplacementNamed(context, '/first');
          } else if (selectedRole == "Mechanic") {
            Navigator.pushReplacementNamed(context, '/mechanic');
          }
          return true; // Login success
        } else {
          _showErrorDialog(context, data['message']);
        }
      } else {
        _showErrorDialog(context, "Login failed. Please try again.");
      }
    } catch (error) {
      print("Error: $error");
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
    return false; // Login failed
  }

  // Helper function to show error dialogs
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
