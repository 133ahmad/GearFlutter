import 'package:flutter/material.dart';
import 'package:gear/controllers/registrationMechanic_controller.dart';

class RegisterMechanicPage extends StatefulWidget {
  @override
  _RegisterMechanicPageState createState() => _RegisterMechanicPageState();
}

class _RegisterMechanicPageState extends State<RegisterMechanicPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final specializationController = TextEditingController();
  final experienceController = TextEditingController();
  final locationController = TextEditingController();
  final latitudeController = TextEditingController();         // added
  final longitudeController = TextEditingController();        // added
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RegistrationController registrationController = RegistrationController();

  final Map<String, bool> selectedWorkdays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };
  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Get selected days as an array
      final selectedDays = selectedWorkdays.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      if (selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one workday.')),
        );
        return;
      }

      final response = await registrationController.handleMechanicRegistration(
        context,
        nameController.text.trim(),
        phoneController.text.trim(),
        emailController.text.trim(),
        specializationController.text.trim(),
        experienceController.text.trim(),
        locationController.text.trim(),
        latitudeController.text.trim(),
        longitudeController.text.trim(),
        passwordController.text.trim(),
        confirmPasswordController.text.trim(),
        '09:00:00', // start_time
        '17:00:00', // end_time
        selectedDays, // Pass the array directly
      );

      if (response['status'] == 'success') {
        Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Registration failed')),
        );
      }
    }
  }

  Widget _buildWorkdayCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Workdays:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...selectedWorkdays.keys.map((day) {
          return CheckboxListTile(
            title: Text(day),
            value: selectedWorkdays[day],
            onChanged: (value) {
              setState(() {
                selectedWorkdays[day] = value ?? false;
              });
            },
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Mechanic')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              Text('Create an Account',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center),
              SizedBox(height: 30),

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: specializationController,
                decoration: InputDecoration(labelText: 'Specialization'),
                validator: (value) => value!.isEmpty ? 'Please enter your specialization' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(labelText: 'Experience (in years)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter your experience' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Please enter your location' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value!.isEmpty ? 'Please enter latitude' : null,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) => value!.isEmpty ? 'Please enter longitude' : null,
              ),
              SizedBox(height: 10),

              _buildWorkdayCheckboxes(),
              SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a password';
                  if (value.length < 8) return 'Password must be at least 8 characters';
                  return null;
                },
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Please confirm your password';
                  if (value != passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: Text('Register'),
              ),
              SizedBox(height: 20),

              Text("Already have an account?", textAlign: TextAlign.center),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
