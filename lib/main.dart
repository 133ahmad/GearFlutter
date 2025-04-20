import 'package:flutter/material.dart';
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

import 'routes/AppRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(AuthController());
  Get.put(MechanicService());
  Get.put(EditProfileController());
  Get.put(LocationController());
  Get.put(PartsController(), permanent: true);
  Get.put(MyOrdersController(), permanent: true);
  Get.put(ScheduleHistoryController(), permanent: true);
  Get.put(ServiceRequestController(), permanent: true);
  Get.put(ScheduleResponseController(), permanent: true);
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gear App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoute.login,
      getPages: [
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
      ],
    );
  }
}
