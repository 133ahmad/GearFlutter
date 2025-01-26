import 'package:flutter/material.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';


class AppRoute {
  static const String registration = '/';
  static const String login = '/login';
  static const String first = '/first';
  static const String mechanic ='/mechanic';
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
    )
  ];
}

// Modified GetPage definition
class GetPage {
  final String name;
  final Widget Function() page;

  GetPage({required this.name, required this.page});
}