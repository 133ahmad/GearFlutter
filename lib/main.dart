import 'package:flutter/material.dart';
import 'package:gear/utils/storage_helper.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gear/controllers/auth_controller.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/controllers/location_controller.dart';
import 'package:gear/controllers/my_orders_controller.dart';
import 'package:gear/controllers/parts_controller.dart';
import 'package:gear/controllers/scheduleHistory_controller.dart';
import 'package:gear/controllers/schedule_response_controller.dart';
import 'package:gear/controllers/servicerequest_controller.dart';
import 'package:gear/controllers/orders_controller.dart';
import 'package:gear/services/mechanic_service.dart';
import 'package:gear/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'routes/AppRoute.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize storage and services
    await GetStorage.init();
    await StorageHelper().init();
    await ApiService().onInit();

    // Initialize controllers
    _initializeControllers();

    runApp(const MyApp());
  } catch (e) {
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Initialization failed: ${e.toString()}'),
          ),
        ),
      ),
    );
  }
}

void _initializeControllers() {
  Get.put(AuthController(httpClient: http.Client()));
  Get.put(MechanicService());
  Get.put(ApiService());
  Get.put(PartsController(), permanent: true);
  Get.put(MyOrdersController(), permanent: true);
  Get.put(ServiceRequestController(), permanent: true);
  Get.put(EditProfileController());

  // Initialize LocationController with error handling
  try {
    Get.put(LocationController(), permanent: true);
  } catch (e) {
    Get.log('LocationController initialization error: $e');
  }

  Get.put(ScheduleHistoryController());
  Get.put(ScheduleResponseController());
  Get.put(OrdersController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gear App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoute.splash,
      getPages: AppRoute.pages,);
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Check login status
      final authController = Get.find<AuthController>();
      final isLoggedIn = await authController.checkLoginStatus();

      // Get location if logged in
      if (isLoggedIn) {
        try {
          await Get.find<LocationController>().fetchLocation();
        } catch (e) {
          Get.log('Location fetch error: $e');
        }
      }

      // Navigate to appropriate screen
      Get.offNamed(isLoggedIn ? AppRoute.home : AppRoute.login);
    } catch (e) {
      Get.offNamed(AppRoute.login);
      Get.snackbar('Error', 'Initialization failed: ${e.toString()}');
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
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 20),
            const Text('Loading...',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}