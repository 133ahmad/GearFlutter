import 'dart:convert';  // Import this for JSON parsing
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationController {
  // Form key to handle form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // URL of your backend API
  final String apiUrl = 'https://gear.com/api/register';

  // Method to register the user
  Future<void> registerUser(BuildContext context) async {
    // Ensure all fields are valid before sending the request
    if (formKey.currentState!.validate()) {
      // Prepare the registration data
      Map<String, String> userData = {
        'name': nameController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
        'age': ageController.text,  // Make sure to include age and country as well
        'country': countryController.text,
      };

      // Send POST request to the Laravel backend
      final response = await http.post(
        Uri.parse(apiUrl),
        body: userData,
      );

      // Check if the registration was successful
      if (response.statusCode == 200) {
        // Parse the response (optional: you can use this to show a success message)
        final Map<String, dynamic> responseData = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful: ${responseData['message']}')),
        );
        // Navigate to login or home page
        Navigator.pushNamed(context, '/login');
      } else {
        // Show error if registration fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    }
  }

  // Method to validate all form fields
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? validateCountry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your country';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  // Method to handle form submission
  void handleRegistration(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Get data from controllers
      String name = nameController.text;
      String age = ageController.text;
      String country = countryController.text;
      String password = passwordController.text;
      String phone = phoneController.text;

      // For now, we will just print the values
      print('Name: $name');
      print('Age: $age');
      print('Country: $country');
      print('Password: $password');
      print('Phone: $phone');

      // Handle registration logic here (e.g., call an API, save data, etc.)

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );

      // Optionally clear the controllers after submission
      clearControllers();
    }
  }

  // Method to clear all form fields
  void clearControllers() {
    nameController.clear();
    ageController.clear();
    countryController.clear();
    passwordController.clear();
    phoneController.clear();
  }
}
