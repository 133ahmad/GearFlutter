import 'package:gear/controllers/login_controller.dart'; // Only keep this one import
import 'package:flutter/material.dart';
// Import HomeScreen

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();  // Form key for validation
  final TextEditingController phoneController = TextEditingController(); // Phone controller
  final TextEditingController passwordController = TextEditingController(); // Password controller

  final LoginController loginController = LoginController();  // Correct initialization of the LoginController

  // Submit method to handle login
  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      loginController.handleLogin(context);  // Call the handleLogin method from the controller
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Phone number input field
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  return loginController.validatePhone(value);  // Use the validatePhone method from the controller
                },
              ),
              // Password input field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  return loginController.validatePassword(value);  // Use the validatePassword method from the controller
                },
              ),
              SizedBox(height: 20),
              // Login button
              ElevatedButton(
                onPressed: () => _submit(context),
                child: Text('Login'),
              ),
              // Register link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');  // Navigate to the Register page
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
