import 'package:flutter/material.dart';
import 'package:gear/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final TextEditingController phoneController = TextEditingController(); // Phone controller
  final TextEditingController passwordController = TextEditingController(); // Password controller
  final LoginController loginController = LoginController(); // LoginController instance

  String _selectedRole = 'Customer'; // Default role

  // Submit method to handle login
  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      loginController.handleLogin(
        context,
        phoneController.text.trim(),
        passwordController.text.trim(),
        _selectedRole,
      );
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
                  return loginController.validatePhone(value);
                },
              ),
              // Password input field
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  return loginController.validatePassword(value);
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
