import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gear/controllers/editprofile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController profileController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              // Profile Image
              GestureDetector(
                onTap: () {
                  _selectImage();
                },
                child: CircleAvatar(
                  backgroundImage: profileController.profileImageUrl.value.isNotEmpty
                      ? FileImage(File(profileController.profileImageUrl.value))
                      : AssetImage('assets/default_profile.png') as ImageProvider,
                  radius: 50,
                ),
              ),
              SizedBox(height: 20),

              // Profile Information Forms
              TextField(
                controller: nameController..text = profileController.profile.value.name ?? '',
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  profileController.updateProfileDetails(value, emailController.text, phoneController.text, cityController.text);
                },
              ),
              TextField(
                controller: emailController..text = profileController.profile.value.email ?? '',
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  profileController.updateProfileDetails(nameController.text, value, phoneController.text, cityController.text);
                },
              ),
              TextField(
                controller: phoneController..text = profileController.profile.value.phone ?? '',
                decoration: InputDecoration(labelText: 'Phone'),
                onChanged: (value) {
                  profileController.updateProfileDetails(nameController.text, emailController.text, value, cityController.text);
                },
              ),
              TextField(
                controller: cityController..text = profileController.profile.value.city ?? '',
                decoration: InputDecoration(labelText: 'City'),
                onChanged: (value) {
                  profileController.updateProfileDetails(nameController.text, emailController.text, phoneController.text, value);
                },
              ),

              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Logic to save profile details can be added here (e.g., sending data to backend)
                  Get.back(); // Go back to previous screen
                },
                child: Text('Save Profile'),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Method to pick an image using ImagePicker
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Update profile image URL in the controller
      profileController.updateProfileImage(pickedFile.path);
    }
  }
}
