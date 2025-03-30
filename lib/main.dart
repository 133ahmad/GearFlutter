import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/Mechanic_chat.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/ServiceRequestScreen.dart';
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/MyOrders.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/schedule_history.dart';
import 'package:gear/views/Mycar.dart';
import 'package:gear/views/assigned_job.dart';
import 'package:gear/views/mechanic_schedule.dart';
import 'package:gear/views/mechanic_setting.dart';
import 'package:gear/views/EmergencyRespond.dart';
import 'package:gear/views/ServiceResponse.dart';
import 'package:gear/views/carParts.dart';
import 'package:gear/controllers/editprofile_controller.dart';
import 'package:gear/controllers/location_controller.dart';
import 'package:gear/controllers/schedule_response_controller.dart';
import 'package:gear/controllers/parts_controller.dart';
import 'package:gear/controllers/my_orders_controller.dart';
import 'package:gear/controllers/scheduleHistory_controller.dart';
import 'package:gear/controllers/servicerequest_controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize local storage

  // Register controllers
  Get.put(EditProfileController());
  Get.put(LocationController());
  Get.put(PartsController(), permanent: true);
  Get.put(MyOrdersController(), permanent: true);
  Get.put(ScheduleHistoryController(), permanent: true);
  Get.put(ServiceRequestController(), permanent: true);
  Get.put(ScheduleResponseController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gear App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Initial screen
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegistrationPage(),
        '/first': (context) => HomeScreen(),
        '/mechanic': (context) => MechanicHomeScreen(),
        '/service_requests': (context) => ServiceRequestScreen(),
        '/emergency': (context) => EmergencyRequestScreen(),
        '/customerChat': (context) => CustomerChatScreen(),
        '/mechanicChat': (context) => MechanicChatScreen(),
        '/myOrders': (context) => MyOrdersScreen(),
        '/orders': (context) => OrdersScreen(),
        '/schedule_history': (context) => ScheduleHistoryScreen(),
        '/myCar': (context) => AddCarScreen(),
        '/assignedJobs': (context) => AssignedJobsScreen(),
        '/mechanicSettings': (context) => MechanicSettingsScreen(),
        '/mechanicSchedule': (context) => MechanicScheduleScreen(),
        '/emergencyResponse': (context) => EmergencyRespondScreen(),
        '/serviceResponse': (context) => ServiceResponseScreen(),
        '/carParts': (context) => CarPartsScreen(),
      },
    );
  }
}