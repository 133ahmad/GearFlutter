import 'package:flutter/material.dart';
import 'package:gear/services/Dio.dart';

class RegistrationPage extends StatelessWidget {
  final DioClient dioClient = DioClient();

  // Register the user
  void registerUser(BuildContext context) async {
    try {
      final response = await dioClient.post('/register', data: {
        'name': 'John Doe',
        'age': 30,
        'country': 'USA',
        'password': '123456',
        'phone': '1234567890',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful, navigate to success page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowSuccess(message: 'Registration Successful!'),
          ),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => registerUser(context),
          child: Text('Register'),
        ),
      ),
    );
  }

  ShowSuccess({required String message}) {}
}
