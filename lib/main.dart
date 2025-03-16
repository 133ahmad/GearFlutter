import 'package:flutter/material.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/ServiceRequestScreen.dart'; // Import the service request screen
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // This sets the LoginPage as the initial screen.
      routes: {
        '/login': (context) => LoginPage(), // Login route
        '/register': (context) => RegistrationPage(), // Registration route
        '/first': (context) => HomeScreen(), // Home screen route
        '/mechanic': (context) => MechanicHomeScreen(), // Mechanic home screen route
        '/service_requests': (context) => ServiceRequestScreen(), // New route for service requests screen
        '/Emergency':(context)=>EmergencyRequestScreen(),

      },
    );
  }
}
