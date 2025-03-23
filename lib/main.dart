import 'package:flutter/material.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/Mechanic_chat.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/ServiceRequestScreen.dart';
import 'package:get/get.dart';
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/MyOrders.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/schedule_history.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/views/Mycar.dart';
import 'package:gear/views/assigned_job.dart';
import 'package:gear/views/mechanic_schedule.dart';
import 'package:gear/views/mechanic_setting.dart';
import 'package:gear/views/EmergencyRespond.dart';
import 'package:gear/controllers/location_controller.dart';
import 'package:gear/views/ServiceResponse.dart';
import 'package:gear/views/carParts.dart';
import 'package:gear/controllers/schedule_response_controller.dart';

void main() {
  Get.put(EditProfileController());
  Get.put(LocationController());
  Get.put(ScheduleController());
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
        '/emergency':(context)=>EmergencyRequestScreen(),
        '/customerChat': (context) => CustomerChatScreen(), // New route for customer chat screen'
        '/mechanicChat': (context) => MechanicChatScreen(), // New route for mechanic chat screen'
        '/myOrders': (context) => MyOrdersScreen(), // New route for my orders screen'
        '/orders': (context) => OrdersScreen(), // New route for orders screen'
        '/schedule_history': (context)=>ScheduleHistoryScreen(),
        '/myCar': (context) => AddCarScreen(),
        '/assignedJobs': (context) => AssignedJobsScreen(),
        '/mechanicSettings': (context) => MechanicSettingsScreen(),
        '/mechanicSchedule': (context) => MechanicScheduleScreen(),
        '/emergencyResponse': (context) => EmergencyRespondScreen(),
        '/serviceResponse': (context) => ServiceResponseScreen(),
        '/carParts': (context) => CarPartsScreen(),
      },
    );
  }
}
