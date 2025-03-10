import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/editprofile_controller.dart';  // Import the controller

class EditProfileScreen extends StatelessWidget {
  // Initialize the controller
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
                    onTap: () {
                      // You can call the updateProfileImage method with an image picker
                      print('Profile picture tapped!');
                    },
                    child: Obx(() => CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(controller.profileImage.value),
                    )),
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
                  onPressed: controller.saveProfile,
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
