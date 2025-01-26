import 'package:flutter/material.dart';

// In your LoginController.dart file
class LoginController {
  void handleLogin(BuildContext context) {
    // Your login logic here
    print("Logging in...");

    // Navigate to the HomeScreen after successful login
    Navigator.pushReplacementNamed(context, '/first');
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }
}

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();  // Form key for validation
  final TextEditingController phoneController = TextEditingController(); // Phone controller
  final TextEditingController passwordController = TextEditingController(); // Password controller
  final LoginController loginController = LoginController();  // Initialize the LoginController

  // Submit method to handle login
  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, proceed to handle login
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
          key: _formKey,  // Attach the form key for validation
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
                onPressed: () => _submit(context),  // Validate and then submit
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
