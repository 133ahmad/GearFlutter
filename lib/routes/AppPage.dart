import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main.dart';
import '../views/Customer_chat.dart';
import '../views/EditProfileScreen.dart';
import '../views/EmergencyRequest.dart';
import '../views/EmergencyRespond.dart';
import '../views/Mechanic_chat.dart';
import '../views/Mechanic_home.dart';
import '../views/MyOrders.dart';
import '../views/Mycar.dart';
import '../views/OrderScreen.dart';
import '../views/Registration_customer.dart';
import '../views/Registration_mechanic.dart';
import '../views/ServiceRequestScreen.dart';
import '../views/ServiceResponse.dart';
import '../views/assigned_job.dart';
import '../views/carParts.dart';
import '../views/home_screen.dart';
import '../views/login.dart';
import '../views/mechanicProfile.dart';
import '../views/mechanic_schedule.dart';
import '../views/schedule_history.dart';

class AppRoute {
  // Route names
  static const String splash = '/splash';
  static const String registrationCustomer = '/registration-customer';
  static const String registrationMechanic = '/registration-mechanic';
  static const String login = '/login';
  static const String home = '/home';
  static const String mechanic = '/mechanic';
  static const String serviceRequests = '/service-requests';
  static const String customerChat = '/customer-chat';
  static const String mechanicChat = '/mechanic-chat';
  static const String editProfile = '/edit-profile';
  static const String emergency = '/emergency';
  static const String myOrders = '/my-orders';
  static const String orders = '/orders';
  static const String scheduleHistory = '/schedule-history';
  static const String myCar = '/my-car';
  static const String assignedJobs = '/assigned-jobs';
  static const String mechanicSettings = '/mechanic-settings';
  static const String mechanicSchedule = '/mechanic-schedule';
  static const String emergencyResponse = '/emergency-response';
  static const String serviceResponse = '/service-response';
  static const String carParts = '/car-parts';
  static const String mechanicProfile = '/mechanic-profile';

  // Route definitions
  static final List<GetPage> pages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: registrationCustomer, page: () => RegisterCustomerPage()),
    GetPage(name: registrationMechanic, page: () => RegisterMechanicPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: mechanic, page: () => MechanicHomeScreen()),
    GetPage(name: serviceRequests, page: () => ServiceRequestForm()),
    GetPage(name: mechanicChat, page: () => MechanicChatScreen()),
    GetPage(name: customerChat, page: () => CustomerChatScreen()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: emergency, page: () => EmergencyRequestScreen()),
    GetPage(name: myOrders, page: () => MyOrdersScreen()),
    GetPage(name: orders, page: () => OrdersScreen()),
    GetPage(name: scheduleHistory, page: () => ScheduleHistoryScreen()),
    GetPage(name: myCar, page: () => AddCarScreen()),
    GetPage(
      name: assignedJobs,
      page: () {
        final mechanicId = int.tryParse(Get.parameters['mechanicId'] ?? '');
        return mechanicId != null
            ? AssignedJobsScreen(mechanicId: mechanicId)
            : Scaffold(body: Center(child: Text('Mechanic ID is required')));
      },
    ),
    GetPage(name: mechanicSchedule, page: () => MechanicScheduleScreen()),
    GetPage(name: emergencyResponse, page: () => EmergencyRespondScreen()),
    GetPage(name: serviceResponse, page: () => ServiceResponseScreen()),
    GetPage(name: carParts, page: () => CarPartsScreen()),
    GetPage(name: mechanicProfile, page: () => MechanicProfileScreen()),
  ];
}