import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationController {
  Future<void> registerUser(
      BuildContext context,
      String name,
      String age,
      String country,
      String phone,
      String password,
      String role,
      ) async {
<<<<<<< HEAD
    String apiUrl = "http://127.0.0.1:8000/api/register"; // Replace with actual Laravel API URL
=======
    String apiUrl = "http://your-laravel-api.com/api/register"; // Replace with actual Laravel API URL
>>>>>>> 11521f51f2daff4bad72cb1b9b70ca6a7fd7cf8f
        /////////////////////////////////////////////////////////////
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': name,
          'age': age,
          'country': country,
          'phone': phone,
          'password': password,
          'role': role.toLowerCase(),
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success']) {
        print("Registration successful!");

        // Navigate based on role
        if (role == "Customer") {
<<<<<<< HEAD
          Navigator.pushReplacementNamed(context, '/first');
        } else if (role == "Mechanic") {
          Navigator.pushReplacementNamed(context, '/mechanic');
=======
          Navigator.pushReplacementNamed(context, '/customer');
        } else if (role == "Mechanic") {
          Navigator.pushReplacementNamed(context, '/first');
>>>>>>> 11521f51f2daff4bad72cb1b9b70ca6a7fd7cf8f
        }
      } else {
        _showErrorDialog(context, data['message']);
      }
    } catch (error) {
      print("Error: $error");
      _showErrorDialog(context, "An error occurred. Please try again.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Registration Failed"),
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
