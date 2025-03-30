import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var profileImage = ''.obs;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  void updateProfileImage(String imagePath) {
    profileImage.value = imagePath;
  }

  void saveProfile() {
    // Save logic here (e.g., send data to API or local storage)
    print("Profile Updated: ${nameController.text}, ${emailController.text}, ${phoneController.text}");
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
