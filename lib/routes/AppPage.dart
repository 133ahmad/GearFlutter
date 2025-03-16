import 'package:flutter/material.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/ServiceRequestScreen.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/chatScreen.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:get/get.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/MyOrders.dart';

class AppRoute {
  static const String registration = '/';
  static const String login = '/login';
  static const String first = '/first';
  static const String mechanic ='/mechanic';
  static const String serviceRequests = '/service_requests';
  static const String chat = '/chat';
  static const String editProfile = '/editProfile';
  static const String emergency='/Emergency';
  static const String myOrders='Myorders';
  static const String orders='orders';


  static final List<GetPage> pages = [
    GetPage(
      name: registration,
      page: () => RegistrationPage(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: first,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: mechanic,
      page: () => MechanicHomeScreen(),
    ),
    GetPage(
        name: serviceRequests,
        page: () => ServiceRequestScreen()
    ),
    GetPage(
      name: AppRoute.chat,
      page: () => ChatMessageItem(message: Get.arguments),  // Passing the argument
    ),
    GetPage(
      name: AppRoute.editProfile,
      page: () => EditProfileScreen(),
    ),
    GetPage(name: emergency, page:
        ()=>EmergencyRequestScreen()
    ),
    GetPage(name: myOrders, page:
        ()=>MyOrdersScreen()
    ),GetPage(name: orders, page:
        ()=>OrdersScreen()
    ),
  ];
}

// Modified GetPage definition
class GetPage {
  final String name;
  final Widget Function() page;

  GetPage({required this.name, required this.page});
}
