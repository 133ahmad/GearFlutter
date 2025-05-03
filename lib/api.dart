import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // Base URL of your backend API
  static const String baseUrl = 'http://192.168.0.102:8000/api';

  // POST request method
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );

      // Check the status code and return response accordingly
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully registered
        return json.decode(response.body); // Parse the response body and return
      } else if (response.statusCode == 400) {
        // Bad request, likely validation errors
        throw Exception('Bad Request: ${response.body}');
      } else if (response.statusCode == 401) {
        // Unauthorized (perhaps invalid credentials)
        throw Exception('Unauthorized: ${response.body}');
      } else if (response.statusCode == 500) {
        // Server error
        throw Exception('Server error: ${response.body}');
      } else {
        // Handle other status codes if necessary
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (error) {
      // Catch any error that occurs during the request
      throw Exception('Error during the request: $error');
    }
  }
}
