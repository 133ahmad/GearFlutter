import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/routes/AppPage.dart';

class HomeScreen extends StatelessWidget {
  final EditProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoute.editProfile),
              child: Obx(() {
                return CircleAvatar(
                  backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                      ? FileImage(File(profileController.profileImageUrl.value))
                      : const AssetImage('assets/default_profile.png') as ImageProvider,
                  radius: 18,
                );
              }),
            ),
            const SizedBox(width: 10),
            const Text('Home'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed(AppRoute.login),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWelcomeMessage(),
            const SizedBox(height: 20),

            // Emergency Request button
            Center(
              child: ElevatedButton(
                onPressed: () => Get.toNamed(AppRoute.emergency),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                child: const Text('Emergency Request', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 30),

            // Main buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMainButton('Schedule', Icons.calendar_today, AppRoute.serviceRequests),
                _buildMainButton('My Orders', Icons.receipt, AppRoute.myOrders),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: _buildMainButton('Schedule History', Icons.history, AppRoute.scheduleHistory),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'My Cars'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoute.customerChat);
          } else if (index == 1) {
            Get.toNamed(AppRoute.myCar);
          } else if (index == 2) {
            Get.toNamed(AppRoute.orders);
          }
        },
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      children: [
        const Text(
          "Welcome Back!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Find the best mechanics near you or request emergency help!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }

  Widget _buildMainButton(String title, IconData icon, String route) {
    return ElevatedButton.icon(
      onPressed: () => Get.toNamed(route),
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }
}
