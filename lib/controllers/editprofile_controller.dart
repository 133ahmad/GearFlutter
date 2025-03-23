import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RxString profileImage = ''.obs; // Holds the selected image path

  void updateProfileImage(String newImage) {
    profileImage.value = newImage;
  }

  void saveProfile() {
    if (_validateForm()) {
      print('Name: ${nameController.text}');
      print('Email: ${emailController.text}');
      print('Phone: ${phoneController.text}');
      print('Profile Image: ${profileImage.value}');
      Get.snackbar('Profile Updated', 'Your profile has been updated successfully.');
    } else {
      Get.snackbar('Validation Error', 'Please fill in all fields correctly.');
    }
  }

  bool _validateForm() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text);
  }
}
