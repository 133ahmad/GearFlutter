import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/routes/AppPage.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:gear/models/car_model.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/controllers/car_controller.dart'; // Controller to manage car data

class HomeScreen extends StatelessWidget {
  final EditProfileController profileController = Get.find(); // Access the controller
  final CarController carController = Get.put(CarController()); // Manage car data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(EditProfileScreen());
              },
              child: Obx(() {
                return CircleAvatar(
                  backgroundImage: profileController.profileImage.value.isNotEmpty
                      ? FileImage(File(profileController.profileImage.value))
                      : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                  radius: 18,
                );
              }),
            ),
            SizedBox(width: 10),
            Text('Home'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.offAllNamed(AppRoute.login);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.emergency);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('Emergency Request', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),

            // Car Section - Checks if the user has a car
            Obx(() {
              return carController.userCar.value == null
                  ? _buildAddCarWidget()
                  : _buildCarInfoWidget(carController.userCar.value!);
            }),

            SizedBox(height: 20),

            // Buttons for Schedule, My Orders, and My Cars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('Schedule', Icons.calendar_today, () {
                  Get.toNamed(AppRoute.serviceRequests);
                }),
                _buildButton('My Orders', Icons.receipt, () {
                  Get.toNamed(AppRoute.myOrders);
                }),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: _buildButton('Schedule History & Upcoming', Icons.event, () {
                Get.toNamed(AppRoute.scheduleHistory);
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.chat),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text('3', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: 'My Cars'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Orders'),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoute.customerChat);
          } else if (index == 1) {
            Get.toNamed(AppRoute.myCar);  // Corrected 'Mycar' to 'myCar'
          } else if (index == 2) {
            Get.toNamed(AppRoute.orders);
          }
        },
      ),
    );
  }

  // Widget to add a car
  Widget _buildAddCarWidget() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.myCar);  // Corrected 'Mycar' to 'myCar'
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Car', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.add, size: 30, color: Colors.grey),
                SizedBox(width: 10),
                Text('Tap to add your car', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to show car details
  Widget _buildCarInfoWidget(Car car) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Car', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${car.make} ${car.model} ${car.year}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('${car.fuelType}', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Button builder
  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        minimumSize: Size(140, 50),
      ),
    );
  }
}