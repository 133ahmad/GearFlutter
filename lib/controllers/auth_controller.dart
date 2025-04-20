import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../routes/AppRoute.dart';

class AuthController extends GetxController {
  final GetStorage _storage = GetStorage();

  final RxnInt currentMechanicId = RxnInt();
  final RxString role = ''.obs;
  final RxBool isLoggedIn = false.obs;

  final String baseUrl = 'http://192.168.0.100:8000/api';  // Ensure this URL matches your Laravel backend

  @override
  void onInit() {
    super.onInit();
    currentMechanicId.value = _storage.read('mechanicId');
    role.value = _storage.read('role') ?? '';
    isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 200) {
        final roleFromResponse = data['role'];
        final token = data['token'];

        role.value = roleFromResponse;
        isLoggedIn.value = true;

        _storage.write('token', token);
        _storage.write('role', roleFromResponse);
        _storage.write('isLoggedIn', true);

        if (roleFromResponse == 'mechanic') {
          currentMechanicId.value = data['mechanic']['id'];
          _storage.write('mechanicId', data['mechanic']['id']);
          Get.offAllNamed(AppRoute.mechanic);
        } else if (roleFromResponse == 'customer') {
          _storage.write('customerId', data['customer']['id']);
          Get.offAllNamed(AppRoute.home);
        }
      } else {
        Get.snackbar('Login Failed', data['message'] ?? 'Unknown error');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login request failed: $e');
    }
  }


  void logout() {
    currentMechanicId.value = null;
    role.value = '';
    isLoggedIn.value = false;

    _storage.remove('mechanicId');
    _storage.remove('role');
    _storage.remove('isLoggedIn');
    _storage.remove('token');

    Get.offAllNamed(AppRoute.login);
  }
}
