import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/routes/AppPage.dart';
import 'package:gear/views/EditProfileScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.to(EditProfileScreen()), // Navigate to Edit Profile
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 18,
              ),
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
                onPressed: () => Get.toNamed(AppRoute.emergency),
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
            Container(
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
                      Image.asset('assets/car.jpg', width: 100, height: 60, fit: BoxFit.cover),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Toyota Corolla 2021', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('Automatic, Petrol', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
          }
        },
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        minimumSize: Size(140, 50),
      ),
    );
  }
}
