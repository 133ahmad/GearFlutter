import 'package:flutter/material.dart';
import 'package:gear/controllers/registration_controller.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? _userRole;

  final RegistrationController registrationController = RegistrationController();

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) return;

    registrationController.registerUser(
      context,
      nameController.text.trim(),
      ageController.text.trim(),
      countryController.text.trim(),
      phoneController.text.trim(),
      passwordController.text.trim(),
      _userRole!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                _buildTextField(nameController, 'Name'),
                _buildTextField(ageController, 'Age', keyboardType: TextInputType.number),
                _buildTextField(countryController, 'Country'),
                _buildTextField(passwordController, 'Password', isPassword: true),
                _buildTextField(phoneController, 'Phone Number', keyboardType: TextInputType.phone),
                SizedBox(height: 10),

                // Dropdown Role Selection
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Role', contentPadding: EdgeInsets.all(8)),
                  value: _userRole,
                  items: [
                    DropdownMenuItem(value: 'Mechanic', child: Text('Mechanic')),
                    DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _userRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Please select a role';
                    return null;
                  },
                ),

                SizedBox(height: 10),

                // Buttons
                Wrap(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 40),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: Text('Register', style: TextStyle(fontSize: 14)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Already have an account? Login', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(),
        ),
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter your $labelText';
          return null;
        },
      ),
    );
  }
}
