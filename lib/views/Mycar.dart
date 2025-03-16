import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/models/car_model.dart';

class AddCarScreen extends StatelessWidget {
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Your Car')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: makeController,
              decoration: InputDecoration(labelText: 'Car Make'),
            ),
            TextField(
              controller: modelController,
              decoration: InputDecoration(labelText: 'Car Model'),
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(labelText: 'Car Year'),
            ),
            TextField(
              controller: fuelTypeController,
              decoration: InputDecoration(labelText: 'Fuel Type'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Create a Car instance
                Car newCar = Car(
                  make: makeController.text,
                  model: modelController.text,
                  year: yearController.text,
                  fuelType: fuelTypeController.text,
                );
                // Save the car data to shared preferences or state management
                Get.back(result: newCar);  // Return car to HomeScreen
              },
              child: Text('Save Car'),
            ),
          ],
        ),
      ),
    );
  }
}
