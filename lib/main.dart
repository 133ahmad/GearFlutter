import 'package:flutter/material.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
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
        '/first':(context) => HomeScreen(),
        '/mechanic':(context)=> MechanicHomeScreen(),
      },
    );
  }
}

