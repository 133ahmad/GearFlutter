import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/location_controller.dart';
import '../routes/AppPage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeApp());
  }

  Future<void> _initializeApp() async {
    try {
      // Ensure controllers are initialized
      await _ensureControllersReady();

      final authController = Get.find<AuthController>();
      final isLoggedIn = await authController.checkLoginStatus();

      // Get location if needed (with error handling)
      if (isLoggedIn) {
        await _getUserLocation();
      }

      // Navigate with delay to ensure splash is visible
      await Future.delayed(Duration(milliseconds: 1500));

      Get.offNamed(isLoggedIn ? AppRoute.home : AppRoute.login);
    } catch (e) {
      Get.log('Splash initialization error: $e');
      Get.offNamed(AppRoute.login);
    }
  }

  Future<void> _ensureControllersReady() async {
    try {
      await Get.putAsync<AuthController>(() async => AuthController(httpClient: Get.find()));
    } catch (e) {
      Get.log('Controller initialization error: $e');
      rethrow;
    }
  }

  Future<void> _getUserLocation() async {
    try {
      final locationController = Get.find<LocationController>();
      if (!locationController.hasLocationPermission.value) {
        await locationController.fetchLocation();
      }
    } catch (e) {
      Get.log('Location error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 120, height: 120),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}