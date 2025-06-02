import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../routes/AppRoute.dart';

class AuthController extends GetxController {
  final GetStorage _storage = GetStorage();
  final http.Client httpClient;

  // Reactive state variables
  final RxnInt currentMechanicId = RxnInt();
  final RxnInt currentCustomerId = RxnInt();
  final RxString role = ''.obs;
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  final RxString authToken = ''.obs;

  final String baseUrl = 'http://192.168.0.102:8000/api';

  AuthController({required this.httpClient});

  @override
  void onInit() {
    super.onInit();
    _loadAuthState();
  }

  void _loadAuthState() {
    try {
      currentMechanicId.value = _storage.read('mechanicId');
      currentCustomerId.value = _storage.read('customerId');
      role.value = _storage.read('role') ?? '';
      isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
      authToken.value = _storage.read('token') ?? '';
    } catch (e) {
      Get.log('Error loading auth state: $e');
    }
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Validation Error', 'Email and password are required');
      return;
    }

    isLoading.value = true;

    try {
      final response = await httpClient.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password},
      ).timeout(const Duration(seconds: 30));

      final data = json.decode(response.body);
      Get.log('Login response: $data');

      if (response.statusCode == 200 && data['status'] == 200) {
        _handleSuccessfulLogin(data);
      } else {
        _handleLoginError(data);
      }
    } on http.ClientException catch (e) {
      Get.snackbar('Connection Error', 'Failed to connect to server');
      Get.log('Login connection error: ${e.message}');
    } on TimeoutException {
      Get.snackbar('Timeout', 'Server response timed out');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
      Get.log('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleSuccessfulLogin(Map<String, dynamic> data) {
    final roleFromResponse = data['role']?.toString() ?? '';
    final token = data['token']?.toString() ?? '';

    // Update state
    role.value = roleFromResponse;
    isLoggedIn.value = true;
    authToken.value = token;

    // Persist data
    _storage.write('token', token);
    _storage.write('role', roleFromResponse);
    _storage.write('isLoggedIn', true);

    if (roleFromResponse == 'mechanic') {
      final mechanic = data['mechanic'];
      if (mechanic != null && mechanic['id'] != null) {
        final mechanicId = int.tryParse(mechanic['id'].toString());
        if (mechanicId != null) {
          currentMechanicId.value = mechanicId;
          _storage.write('mechanicId', mechanicId);
          Get.offAllNamed(AppRoute.mechanic);
          return;
        }
      }
      Get.snackbar('Login Error', 'Mechanic data is missing or invalid');
    } else if (roleFromResponse == 'customer') {
      final customer = data['customer'];
      if (customer != null && customer['id'] != null) {
        final customerId = int.tryParse(customer['id'].toString());
        if (customerId != null) {
          currentCustomerId.value = customerId;
          _storage.write('customerId', customerId);
          Get.offAllNamed(AppRoute.home);
          return;
        }
      }
      Get.snackbar('Login Error', 'Customer data is missing or invalid');
    } else {
      Get.snackbar('Login Error', 'Unknown role received');
    }
  }

  void _handleLoginError(Map<String, dynamic> data) {
    final errorMessage = data['message']?.toString() ?? 'Login failed';
    if (data['errors'] != null) {
      final errors = data['errors'] as Map<String, dynamic>;
      final detailedErrors = errors.entries
          .map((e) => '${e.key}: ${e.value.join(', ')}')
          .join('\n');
      Get.snackbar('Login Failed', detailedErrors);
    } else {
      Get.snackbar('Login Failed', errorMessage);
    }
  }

  Future<void> logout() async {
    try {
      if (authToken.value.isNotEmpty) {
        await httpClient.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${authToken.value}',
          },
        ).timeout(const Duration(seconds: 10));
      }
    } catch (e) {
      Get.log('Logout API error: $e');
    }

    _clearAuthState();
    Get.offAllNamed(AppRoute.login);
  }

  void _clearAuthState() {
    currentMechanicId.value = null;
    currentCustomerId.value = null;
    role.value = '';
    isLoggedIn.value = false;
    authToken.value = '';

    _storage.remove('mechanicId');
    _storage.remove('customerId');
    _storage.remove('role');
    _storage.remove('isLoggedIn');
    _storage.remove('token');
  }

  Future<bool> checkLoginStatus() async {
    if (!isLoggedIn.value) return false;

    try {
      final response = await httpClient.get(
        Uri.parse('$baseUrl/check-auth'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${authToken.value}',
        },
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      Get.log('Auth check error: $e');
      return false;
    }
  }
}
