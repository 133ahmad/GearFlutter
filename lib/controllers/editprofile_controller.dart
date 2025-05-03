import 'package:get/get.dart';
import 'package:gear/models/profile_model.dart';

class EditProfileController extends GetxController {
  // Observable to hold profile data
  var profile = ProfileModel().obs;

  // Observable for profile image URL
  var profileImageUrl = 'assets/default_profile.png'.obs;

  // Method to update the profile image
  void updateProfileImage(String imageUrl) {
    profileImageUrl.value = imageUrl;
    profile.update((val) {
      val?.profileImageUrl = imageUrl;
    });
  }

  // Method to update profile details
  void updateProfileDetails(String name, String email, String phone, String city) {
    profile.update((val) {
      val?.name = name;
      val?.email = email;
      val?.phone = phone;
      val?.city = city;
    });
  }
}
