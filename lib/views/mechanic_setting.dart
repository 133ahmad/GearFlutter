import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/mechanic_controller.dart';

class MechanicSettingsScreen extends StatelessWidget {
  final MechanicController mechanicController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => SwitchListTile(
              title: Text('Enable Notifications'),
              value: mechanicController.notificationEnabled.value,
              onChanged: mechanicController.toggleNotification,
            )),
            Obx(() => SwitchListTile(
              title: Text('Dark Mode'),
              value: mechanicController.darkModeEnabled.value,
              onChanged: mechanicController.toggleDarkMode,
            )),
          ],
        ),
      ),
    );
  }
}