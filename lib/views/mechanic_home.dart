import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/routes/AppPage.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:gear/models/car_model.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/controllers/car_controller.dart';
import 'package:gear/controllers/location_controller.dart';


class MechanicHomeScreen extends StatelessWidget {
  final EditProfileController profileController = Get.find(); // Access the controller
  final CarController carController = Get.put(CarController()); // Manage car data
  final LocationController locationController = Get.find(); // Access the location controller

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
            Text('Mechanic Home'),
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
            // Button to reply to emergency requests
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.emergencyResponse); // Navigate to emergency response screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('Reply to Emergency Requests', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),

            // Display location status
            Obx(() {
              return Center(
                child: Text(
                  locationController.hasLocationPermission.value
                      ? 'Location Access Granted\n${locationController.currentLocation.value}'
                      : 'Location Access Denied',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }),
            SizedBox(height: 20),

            // Assigned Jobs Section
            Obx(() {
              return carController.userCar.value == null
                  ? _buildNoJobsWidget()
                  : _buildAssignedJobsWidget(carController.userCar.value!);
            }),

            SizedBox(height: 20),

            // Buttons for Service Requests, Assigned Jobs, and Schedule
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('Service Respond', Icons.assignment, () {
                  Get.toNamed(AppRoute.serviceResponse);
                }),
                _buildButton('Assigned Jobs', Icons.work, () {
                  Get.toNamed(AppRoute.assignedJobs);
                }),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: _buildButton('Schedule & Availability', Icons.event, () {
                Get.toNamed(AppRoute.mechanicSchedule);
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
          BottomNavigationBarItem(icon: Icon(Icons.car_repair), label: 'Car Parts'), // Updated to Car Parts
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          if (index == 0) {
            Get.toNamed(AppRoute.mechanicChat);
          } else if (index == 1) {
            Get.toNamed(AppRoute.carParts);
          } else if (index == 2) {
            Get.toNamed(AppRoute.mechanicSettings);
          }
        },
      ),
    );
  }

  // Widget to show no jobs assigned
  Widget _buildNoJobsWidget() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.assignedJobs);
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
            Text('Assigned Jobs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.work, size: 30, color: Colors.grey),
                SizedBox(width: 10),
                Text('No jobs assigned yet', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to show assigned job details
  Widget _buildAssignedJobsWidget(Car car) {
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
          Text('Assigned Job', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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