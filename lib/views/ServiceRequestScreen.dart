import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceRequestScreen extends StatefulWidget {
  @override
  _ServiceRequestScreenState createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  String _description = '';
  String _serviceType = 'Basic Repair';
  DateTime _scheduledDate = DateTime.now();
  String _contactNumber = '';
  String _preferredTime = 'Morning';

  List<String> _serviceTypes = ['Basic Repair', 'Engine Work', 'Tire Replacement', 'AC Repair'];

  // Method to submit the service request
  Future<void> _submitServiceRequest() async {
    if (_formKey.currentState!.validate()) {
      // API URL to your Laravel backend
      var url = Uri.parse('https://your-laravel-api.com/api/service-request');

      // Send a POST request to the server
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'description': _description,
          'service_type': _serviceType,
          'contact_number': _contactNumber,
          'preferred_time': _preferredTime,
          'scheduled_date': _scheduledDate.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        // Successfully submitted the request
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Service request submitted successfully')));
        // Optionally, navigate to another page or clear the form
        // Navigator.pop(context);
      } else {
        // Failed to submit the request
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit service request')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request a Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Service Type Dropdown
                DropdownButtonFormField<String>(
                  value: _serviceType,
                  onChanged: (value) {
                    setState(() {
                      _serviceType = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Service Type',
                    border: OutlineInputBorder(),
                  ),
                  items: _serviceTypes.map((service) {
                    return DropdownMenuItem(
                      child: Text(service),
                      value: service,
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Description Text Field
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Description of the Issue',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Contact Number Text Field
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _contactNumber = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Preferred Time Dropdown
                DropdownButtonFormField<String>(
                  value: _preferredTime,
                  onChanged: (value) {
                    setState(() {
                      _preferredTime = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Preferred Time',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Morning', 'Afternoon', 'Evening'].map((time) {
                    return DropdownMenuItem(
                      child: Text(time),
                      value: time,
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Scheduled Date Picker
                Row(
                  children: [
                    Text('Scheduled Date:'),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _scheduledDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != _scheduledDate) {
                          setState(() {
                            _scheduledDate = pickedDate;
                          });
                        }
                      },
                      child: Text('${_scheduledDate.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitServiceRequest,
                  child: Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
