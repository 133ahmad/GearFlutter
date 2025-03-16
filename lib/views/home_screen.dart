import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/routes/AppPage.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:gear/views/Mycar.dart';
import 'package:gear/models/car_model.dart';
class HomeScreen extends StatelessWidget {
  Car? userCar;  // This will hold the car data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("Navigating to Edit Profile...");
                Get.to(EditProfileScreen()); // Navigate to Edit Profile
              },
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
              print("Logging out...");
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
                  print("Navigating to Emergency Request...");
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
            // If user has a car, show car info. Otherwise, show the "My Car" button
            userCar == null
                ? GestureDetector(
              onTap: () {
                print("Navigating to Add Car...");
                Get.toNamed(AppRoute.Mycar);
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
                        Icon(Icons.add, size: 30, color: Colors.grey), // Placeholder icon for no car
                        SizedBox(width: 10),
                        Text('Tap to add your car', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : Container(
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
                      Image.asset('assets/images/car.png', width: 100, height: 60, fit: BoxFit.cover),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${userCar!.make} ${userCar!.model} ${userCar!.year}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('${userCar!.fuelType}', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Buttons for Schedule, My Orders, and My Cars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('Schedule', Icons.calendar_today, () {
                  print("Navigating to Schedule...");
                  Get.toNamed(AppRoute.serviceRequests);
                }),
                _buildButton('My Orders', Icons.receipt, () {
                  print("Navigating to My Orders...");
                  Get.toNamed(AppRoute.myOrders);
                }),
              ],
            ),
            SizedBox(height: 10),
            // Schedule History & Upcoming
            Center(
              child: _buildButton('Schedule History & Upcoming', Icons.event, () {
                print("Navigating to Schedule History...");
                Get.toNamed(AppRoute.scheduleHistory);
              }),
            ),
            SizedBox(height: 10),
            // My Cars Button
            Center(
              child: _buildButton('My Cars', Icons.directions_car, () {
                print("Navigating to My Cars...");
                Get.toNamed(AppRoute.Mycar);  // Navigate to AddCarScreen
              }),
            ),
            SizedBox(height: 10),
            // Orders Button
            Center(
              child: _buildButton('Orders', Icons.shopping_cart, () {
                print("Navigating to Orders...");
                Get.toNamed(AppRoute.orders);  // Navigate to Orders page
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
          print("Bottom Navigation tapped at index $index");
          if (index == 0) {
            Get.toNamed(AppRoute.customerChat);  // Navigate to Customer Chat
          } else if (index == 1) {
            Get.toNamed(AppRoute.Mycar);  // Navigate to My Car
          } else if (index == 2) {
            Get.toNamed(AppRoute.orders);  // Navigate to Orders
          }
        },
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: () {
        print("Button pressed: $text");
        onPressed();
      },
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
