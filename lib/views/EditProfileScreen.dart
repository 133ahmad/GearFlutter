import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gear/controllers/editprofile_controller.dart';  // Import the controller

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
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile picture
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        controller.updateProfileImage(pickedFile.path);
                      }
                    },
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 60,
                        backgroundImage: controller.profileImage.value.isNotEmpty
                            ? FileImage(File(controller.profileImage.value))
                            : AssetImage('assets/profile_placeholder.png') as ImageProvider,
                        child: controller.profileImage.value.isEmpty
                            ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                            : null,
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),

                // Name field
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Email field
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),

                // Phone number field
                TextFormField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),

                // Save button
                ElevatedButton(
                  onPressed: () {
                    controller.saveProfile();
                    Get.back(); // Go back after saving
                  },
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}