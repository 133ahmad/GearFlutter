import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gear/utils/api_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegistrationController {
  final storage = GetStorage();

  Future<Map<String, dynamic>> handleMechanicRegistration(
      BuildContext context,
      String name,
      String phone,
      String email,
      String specialization,
      String experience,
      String location,
      String latitude,
      String longitude,
      String password,
      String passwordConfirmation,
      String startTime,
      String endTime,
      List<String> workdays,  // Accept as a List of Strings
      ) async {
    final registerMechanicUrl = Uri.parse(ApiConstants.registerMechanic);

    try {
      final response = await http.post(
        registerMechanicUrl,
        headers: {'Accept': 'application/json'},
        body: {
          'name': name,
          'phone': phone,
          'email': email,
          'specialization': specialization,
          'experience': experience,
          'location': location,
          'latitude': latitude,  // Added latitude
          'longitude': longitude, // Added longitude
          'password': password,
          'password_confirmation': passwordConfirmation,
          'start_time': startTime,
          'end_time': endTime,
          'workdays': jsonEncode(workdays), // Send as array
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'status': 'success',
          'message': data['message'] ?? 'Registration successful',
        };
      } else {
        return {
          'status': 'error',
          'message': data['message'] ?? 'Something went wrong',
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'An error occurred: $e',
      };
    }
  }
}