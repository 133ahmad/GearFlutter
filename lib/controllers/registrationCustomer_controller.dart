import 'package:flutter/material.dart';
import 'package:gear/api.dart';

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
      final response = await Api.post('/register/customer', {
        'name': name,
        'phone': phone,
        'email': email,
        'location': location,
        'password': password,
        'password_confirmation': passwordConfirmation, // required by Laravel
      });

      return response;
    } catch (error) {
      return {'status': 'error', 'message': error.toString()};
    }
  }
}
