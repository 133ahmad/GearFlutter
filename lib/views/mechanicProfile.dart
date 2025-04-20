import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/mechanic_controller.dart';
import 'package:gear/models/mechanic.dart';

class MechanicProfileScreen extends StatelessWidget {
  final MechanicController mechanicController = Get.put(MechanicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Profile'),
      ),
      body: Obx(() {
        if (mechanicController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (mechanicController.mechanic.value == null) {
          return Center(child: Text('No profile data available.'));
        }

        Mechanic mechanic = mechanicController.mechanic.value!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${mechanic.name}', style: TextStyle(fontSize: 20)),
              Text('Email: ${mechanic.email}', style: TextStyle(fontSize: 16)),
              Text('Phone: ${mechanic.phone}', style: TextStyle(fontSize: 16)),
              Text('Location: ${mechanic.location}', style: TextStyle(fontSize: 16)),
              Text('Specialization: ${mechanic.specialization}', style: TextStyle(fontSize: 16)),
              Text('Experience: ${mechanic.experience} years', style: TextStyle(fontSize: 16)),
              Text('Rating: ${mechanic.rating}/5', style: TextStyle(fontSize: 16)),
              Text('Availability: ${mechanic.availability}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Update availability logic
                  mechanicController.updateMechanicAvailability(mechanic.id, 'Available');
                },
                child: Text('Update Availability'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
