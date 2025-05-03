import 'package:flutter/material.dart';
import 'package:gear/utils/api_constants.dart'; // Assuming api_constants.dart contains your base URL.
import 'package:gear/api.dart';  // Make sure to include your custom API handler for POST requests

class RegistrationController {
  Future<Map<String, dynamic>> handleCustomerRegistration(
      BuildContext context,
      String name,
      String phone,
      String email,
      String location,
      String password,
      String passwordConfirmation,
      ) async {
    try {
      final String registerUrl = '${ApiConstants.registerCustomer}';

      // Make a POST request to the registration endpoint
      final response = await Api.post(registerUrl, {
        'name': name,
        'phone': phone,
        'email': email,
        'location': location,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      // Check if the response is JSON or HTML
      if (response is Map<String, dynamic>) {
        // If the response is a Map, it's JSON. Handle it normally.
        return response;
      } else {
        // If it's not JSON (could be an HTML error page), show an error.
        return {
          'status': 'error',
          'message': 'Unexpected error occurred. Please try again later.',
        };
      }
    } catch (error) {
      return {
        'status': 'error',
        'message': error.toString(),
      };
    }
  }
}
