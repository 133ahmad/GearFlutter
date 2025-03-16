import 'package:flutter/material.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/ServiceRequestScreen.dart'; // Import the service request screen
import 'package:get/get.dart';
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/MyOrders.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/schedule_history.dart';

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
        '/service_request': (context) => ServiceRequestScreen(), // New route for service requests screen
        '/Customerchat': (context) => ChatPage(), // New route for customer chat screen'
        '/mechanicchat': (context) => ChatPage(), // New route for mechanic chat screen'
        '/myOrders': (context) => MyOrdersScreen(), // New route for my orders screen'
        '/orders': (context) => OrdersScreen(), // New route for orders screen'
        '/schedule_history': (context)=>ScheduleHistoryScreen(),
      },
    );
  }
}
