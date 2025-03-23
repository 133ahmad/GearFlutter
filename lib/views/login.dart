// screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/login_controller.dart'; // Import the LoginController

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController phoneController = TextEditingController(); // Phone controller
  final TextEditingController passwordController = TextEditingController(); // Password controller
  final LoginController loginController = LoginController(); // LoginController instance

  String _selectedRole = 'Customer'; // Default role

  // Submit method to handle login
  void _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      // For testing, use the handleLogin method (mock login)
      await loginController.handleLogin(
        context,
        phoneController.text.trim(),
        passwordController.text.trim(),
        _selectedRole,
      );

      // For real login (uncomment this when ready to test with real API)
      // bool loginSuccess = await loginController.handleLoginReal(
      //   context,
      //   phoneController.text.trim(),
      //   passwordController.text.trim(),
      //   _selectedRole,
      // );

      // if (!loginSuccess) {
      //   // Handle login failure
      //   print("Login failed!");
      // }
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              // Password input field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Role Selection
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Select Role', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    RadioListTile(
                      title: Text('Customer'),
                      value: 'Customer',
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Mechanic'),
                      value: 'Mechanic',
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value.toString();
                        });
                      },
                    ),
                  ],
                ),
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
                  Navigator.pushNamed(context, '/register');
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
