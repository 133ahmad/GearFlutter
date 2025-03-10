import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/routes/AppPage.dart'; // Import AppPage for routes
import 'package:gear/views/ServiceRequestScreen.dart'; // Import the ServiceRequestScreen
import 'package:gear/views/chatScreen.dart';// Import ChatScreen
import 'package:gear/views/EditProfileScreen.dart'; // Import EditProfileScreen
void main() {
  runApp(MaterialApp(home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              print("Logout button pressed");
              Get.offAllNamed(AppRoute.login);  // Use Get for logout navigation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Container(
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the ServiceRequestScreen when "Emergency" is pressed
              Get.toNamed(AppRoute.serviceRequests);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text('Emergency', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(context, 'Schedule Appointment', Icons.calendar_today, () {}),
              _buildButton(context, 'Edit Profile', Icons.person, () {
                // Navigate to Profile Edit Screen
                Get.to(EditProfileScreen());
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search Mechanic'),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate to Chat Screen
            Get.to(AppRoute.chat);
          } else {
            // Navigate to Search Mechanic (to be implemented)
          }
        },
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text, textAlign: TextAlign.center),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}
