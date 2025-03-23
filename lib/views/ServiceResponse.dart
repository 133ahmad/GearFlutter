import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/schedule_response_controller.dart'; // Import the ScheduleController

class ServiceResponseScreen extends StatefulWidget {
  @override
  _ServiceResponseScreenState createState() => _ServiceResponseScreenState();
}

class _ServiceResponseScreenState extends State<ServiceResponseScreen> {
  final ScheduleController scheduleController = Get.find(); // Access the ScheduleController
  bool _isLoading = false; // Boolean to track loading state

  // Simulate accepting a service request (replace with your actual logic)
  Future<void> _acceptRequest() async {
    setState(() {
      _isLoading = true; // Show spinner
    });

    // Simulate a network delay (replace with your API call)
    await Future.delayed(Duration(seconds: 2));

    // Add the request to the schedule
    scheduleController.addToSchedule(
      customerName: 'John Doe',
      carDetails: 'Toyota Corolla 2020',
      issue: 'Engine overheating',
      response: 'Accepted', // No text input, so we use a default response
    );

    setState(() {
      _isLoading = false; // Hide spinner
    });

    // Show a success message
    Get.snackbar('Request Accepted', 'The service request has been added to your schedule.');
    Get.offNamed('/mechanicSchedule'); // Navigate to the schedule screen
  }

  // Simulate declining a service request (replace with your actual logic)
  Future<void> _declineRequest() async {
    setState(() {
      _isLoading = true; // Show spinner
    });

    // Simulate a network delay (replace with your API call)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false; // Hide spinner
    });

    // Show a decline message
    Get.snackbar('Request Declined', 'The service request has been declined.');
    Get.back(); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Response'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Service Request Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Customer: John Doe'),
            Text('Car: Toyota Corolla 2020'),
            Text('Issue: Engine overheating'),
            Text('Location: 123 Main St, City A'),
            Text('Requested Date: 2023-10-25'),
            Text('Requested Time: 10:00 AM'),
            SizedBox(height: 20),
            Center(
              child: _isLoading
                  ? CircularProgressIndicator() // Show spinner when loading
                  : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _acceptRequest,
                    child: Text('Accept'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _declineRequest,
                    child: Text('Decline'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}