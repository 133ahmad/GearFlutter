import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gear/controllers/editprofile_controller.dart';  // Import your controller

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture section
              Center(
                child: GestureDetector(
                  onTap: () async {
                    // Image picker logic
                    final ImagePicker picker = ImagePicker();
                    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      controller.updateProfileImage(pickedFile.path);  // Update the profile image
                    }
                  },
                  child: Obx(() {
                    return CircleAvatar(
                      radius: 60,
                      backgroundImage: controller.profileImage.value == 'https://example.com/profile_image.jpg'
                          ? AssetImage('assets/profile_placeholder.png') // Placeholder if no image is selected
                          : NetworkImage(controller.profileImage.value) as ImageProvider,
                      child: controller.profileImage.value == 'https://example.com/profile_image.jpg'
                          ? Icon(Icons.camera_alt, size: 40, color: Colors.white)
                          : null, // Show camera icon if no profile picture
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

              // Save Changes Button
              Center(
                child: ElevatedButton(
                  onPressed: controller.saveProfile,
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
