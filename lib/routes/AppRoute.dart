import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';
import '../main.dart';

import '../views/Customer_chat.dart';
import '../views/EditProfileScreen.dart';
import '../views/EmergencyRequest.dart';
import '../views/EmergencyRespond.dart';
import '../views/Mechanic_chat.dart';
import '../views/Mechanic_home.dart';
import '../views/MyOrders.dart';
import '../views/Mycar.dart';
import '../views/OrderScreen.dart';
import '../views/Registration_customer.dart';
import '../views/Registration_mechanic.dart';
import '../views/ServiceRequestScreen.dart';
import '../views/ServiceResponse.dart';
import '../views/assigned_job.dart';
import '../views/carParts.dart';
import '../views/home_screen.dart';
import '../views/login.dart';
import '../views/mechanicProfile.dart';
import '../views/mechanic_schedule.dart';
import '../views/schedule_history.dart';


class AppRoute {
  static const String registerCustomer = "/registerCustomer";
  static const String registerMechanic= "/registerMechanic";
  static const String login = "/login";
  static const String home = "/home";
  static const String mechanic = "/mechanic";
  static const String serviceRequests = "/service_requests";
  static const String chat = "/chat";
  static const String editProfile = "/editProfile";
  static const String emergency = "/emergency";
  static const String myOrders = "/myOrders";
  static const String orders = "/orders";
  static const String scheduleHistory = "/schedule-history";
  static const String mechanicChat = "/mechanicChat";
  static const String customerChat = "/customerChat";
  static const String myCar = "/myCar";
  static const String assignedJobs = '/assignedJobs';
  static const String mechanicSettings = '/mechanicSettings';
  static const String mechanicSchedule='/mechanicSchedule';
  static const String serviceResponse = '/serviceResponse';
  static const String carParts = '/carParts';
  static const String emergencyResponse = '/emergencyResponse';
  static const String searchMechanic = '/searchMechanic';
  static const String mechanicProfile='/mechanicProfile';
  static const String splash ='/splash_screen';

  static final pages = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: registerCustomer, page: () => RegisterCustomerPage()),
    GetPage(name: mechanic, page: () => MechanicHomeScreen()),
    GetPage(name: emergencyResponse, page: () => EmergencyRequestScreen()),
    GetPage(name: emergency, page: () => EmergencyRequestScreen()),
    GetPage(name: myOrders, page: () => MyOrdersScreen()),
    GetPage(name: orders, page: () => OrdersScreen()),
    GetPage(name: scheduleHistory, page: () => ScheduleHistoryScreen()),
    GetPage(name: mechanicChat, page: () => MechanicChatScreen()),
    GetPage(name: customerChat, page: () => CustomerChatScreen()),
    GetPage(name: myCar, page: () => AddCarScreen()),
    GetPage(name: assignedJobs, page: () => AssignedJobsScreen(mechanicId: 0)), // Replace with actual logic
    GetPage(name: mechanicSchedule, page: () => MechanicScheduleScreen()),
    GetPage(name: serviceResponse, page: () => ServiceResponseScreen()),
    GetPage(name: carParts, page: () => CarPartsScreen()),
    GetPage(name: mechanicProfile, page: () => MechanicProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: serviceRequests, page: () => ServiceRequestForm()),

  ];
}




