import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Customer.dart';

class CustomerService {
  final GetStorage _storage = GetStorage();

  // Set the base API URL
  final String baseUrl = 'http://192.168.0.100:8000/api';

  // Fetch Customer Profile
  Future<Customer?> getCustomerProfile(int id) async {
    final token = _storage.read('token'); // Retrieve token from storage

    // Construct the correct URL for fetching customer profile
    final response = await http.get(
      Uri.parse('$baseUrl/customer/$id'),  // Use baseUrl
      headers: {
        'Authorization': 'Bearer $token',  // Add token for authorization
        'Accept': 'application/json',      // Set content type to JSON
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Customer.fromJson(data);  // Return Customer object
    } else {
      print('Failed to load customer: ${response.body}');
      return null;
    }
  }

  // Update Customer Profile
  Future<Customer?> updateCustomerProfile(int id, Customer updatedCustomer) async {
    final token = _storage.read('token');  // Retrieve token from storage

    final response = await http.put(
      Uri.parse('$baseUrl/customer/$id'),  // Use baseUrl for updating
      headers: {
        'Authorization': 'Bearer $token',  // Add token for authorization
        'Accept': 'application/json',      // Set content type to JSON
        'Content-Type': 'application/json', // Specify the request body content type
      },
      body: json.encode(updatedCustomer.toJson()),  // Send the updated customer data as JSON
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Customer.fromJson(data);  // Return updated Customer object
    } else {
      print('Failed to update customer: ${response.body}');
      return null;
    }
  }
}
