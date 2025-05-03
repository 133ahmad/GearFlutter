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
import 'package:gear/services/mechanic_service.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/Mechanic_home.dart';
import 'package:gear/views/Registration_customer.dart';
import 'package:gear/views/Registration_mechanic.dart';
import 'package:gear/views/ServiceRequestScreen.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/MyOrders.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/schedule_history.dart';
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/Mechanic_chat.dart';
import 'package:gear/views/Mycar.dart';
import 'package:gear/views/assigned_job.dart';
import 'package:gear/views/mechanic_schedule.dart';
import 'package:gear/views/ServiceResponse.dart';
import 'package:gear/views/carParts.dart';
import 'package:gear/views/EmergencyRespond.dart';
import 'package:gear/views/mechanicProfile.dart';
import 'package:gear/services/api_service.dart';
import 'controllers/orders_controller.dart';
import 'routes/AppRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Show splash screen immediately
  runApp(const SplashScreen());

  try {
    // Initialize storage first
    await GetStorage.init();

    // Initialize essential services in parallel
    await Future.wait([
      StorageHelper().init(),
      ApiService().onInit(),
    ]);

    // Initialize controllers
    _initializeControllers();

    // Replace splash with main app
    runApp(const MyApp());
  } catch (e) {
    // Handle initialization errors
    runApp(ErrorApp(error: e.toString()));
  }
}

void _initializeControllers() {
  // Essential controllers that need to be available immediately
  Get.put(AuthController());
  Get.put(MechanicService());
  Get.put(ApiService());
  // Permanent controllers
  Get.put(PartsController(), permanent: true);
  Get.put(MyOrdersController(), permanent: true);
  Get.put(ServiceRequestController(), permanent: true);

  // Other controllers
  Get.put(EditProfileController());
  Get.put(LocationController());
  Get.put(ScheduleHistoryController());
  Get.put(ScheduleResponseController());
  Get.put(OrdersController());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue, // Customize as needed
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 100), // Replace with your app logo
              const SizedBox(height: 20),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 50, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Initialization Error',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(error),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => main(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
      initialRoute: AppRoute.login,
      getPages: _getAppPages(),
    );
  }

  List<GetPage> _getAppPages() {
    return [
      GetPage(name: AppRoute.login, page: () => LoginPage()),
      GetPage(name: AppRoute.registerCustomer, page: () => RegisterCustomerPage()),
      GetPage(name: AppRoute.registerMechanic, page: () => RegisterMechanicPage()),
      GetPage(name: AppRoute.home, page: () => HomeScreen()),
      GetPage(name: AppRoute.mechanic, page: () => MechanicHomeScreen()),
      GetPage(name: AppRoute.serviceRequests, page: () => ServiceRequestForm()),
      GetPage(name: AppRoute.emergency, page: () => EmergencyRequestScreen()),
      GetPage(name: AppRoute.myOrders, page: () => MyOrdersScreen()),
      GetPage(name: AppRoute.orders, page: () => OrdersScreen()),
      GetPage(name: AppRoute.scheduleHistory, page: () => ScheduleHistoryScreen()),
      GetPage(name: AppRoute.customerChat, page: () => CustomerChatScreen()),
      GetPage(name: AppRoute.mechanicChat, page: () => MechanicChatScreen()),
      GetPage(name: AppRoute.myCar, page: () => AddCarScreen()),
      GetPage(name: AppRoute.editProfile, page: () => EditProfileScreen()),

      GetPage(
        name: AppRoute.assignedJobs,
        page: () {
          final mechanicIdParam = Get.parameters['mechanicId'];
          if (mechanicIdParam != null) {
            final mechanicId = int.tryParse(mechanicIdParam) ?? 0;
            return AssignedJobsScreen(mechanicId: mechanicId);
          }
          final fallbackId = Get.find<AuthController>().currentMechanicId.value ?? 0;
          return AssignedJobsScreen(mechanicId: fallbackId);
        },
      ),
      GetPage(name: AppRoute.mechanicSchedule, page: () => MechanicScheduleScreen()),
      GetPage(name: AppRoute.serviceResponse, page: () => ServiceResponseScreen()),
      GetPage(name: AppRoute.carParts, page: () => CarPartsScreen()),
      GetPage(name: AppRoute.emergencyResponse, page: () => EmergencyRespondScreen()),
      GetPage(name: AppRoute.mechanicProfile, page: () => MechanicProfileScreen()),

    ];
  }
}