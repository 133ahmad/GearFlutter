import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  // Define TextEditingControllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Profile picture (you can use image picker logic here)
  RxString profileImage = 'https://example.com/profile_image.jpg'.obs;

  // Method to validate and save profile data
  void saveProfile() {
    if (_validateForm()) {
      // You can perform your API call here to save the updated profile data.
      // For now, we'll just print the data for demonstration purposes.
      print('Name: ${nameController.text}');
      print('Email: ${emailController.text}');
      print('Phone: ${phoneController.text}');
      print('Profile Image: ${profileImage.value}');

      // Show a success message after saving
      Get.snackbar('Profile Updated', 'Your profile has been updated successfully.');
    } else {
      Get.snackbar('Validation Error', 'Please fill in all fields correctly.');
    }
  }

  // Method to validate form
  bool _validateForm() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      return false;
    }
    return true;
  }

  // You can add methods to update the profile image here, e.g., with an image picker
  void updateProfileImage(String newImage) {
    profileImage.value = newImage;
  }
}
