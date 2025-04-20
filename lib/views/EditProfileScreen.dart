import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/editprofile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture (optional)
              GestureDetector(
                onTap: () async {
                  // Handle image selection (optional)
                },
                child: Obx(() {
                  return CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.profileImage.value.isNotEmpty
                        ? NetworkImage(controller.profileImage.value)
                        : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                    child: controller.profileImage.value.isEmpty
                        ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                        : null,
                  );
                }),
              ),
              SizedBox(height: 20),

              // Name
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 20),

              // Email
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),

              // Phone
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),

              // City
              TextField(
                controller: controller.cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  controller.updateProfile();
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
