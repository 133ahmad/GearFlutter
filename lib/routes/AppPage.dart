import 'package:get/get.dart';
import 'package:gear/views/EmergencyRequest.dart';
import 'package:gear/views/ServiceRequestScreen.dart';
import 'package:gear/views/registration.dart';
import 'package:gear/views/login.dart';
import 'package:gear/views/home_screen.dart';
import 'package:gear/views/mechanic_home.dart';
import 'package:gear/views/EditProfileScreen.dart';
import 'package:gear/views/OrderScreen.dart';
import 'package:gear/views/MyOrders.dart';
import 'package:gear/views/schedule_history.dart';
import 'package:gear/views/Mechanic_chat.dart';
import 'package:gear/views/Mycar.dart';
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/assigned_job.dart';
import 'package:gear/views/mechanic_setting.dart';
import 'package:gear/views/mechanic_schedule.dart';
import 'package:gear/views/EmergencyRespond.dart';
import 'package:gear/views/carParts.dart';
import 'package:gear/views/ServiceResponse.dart';

class AppRoute {
  static const String registration = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String mechanic = '/mechanic';
  static const String serviceRequests = '/service_requests';
  static const String customerChat = '/customerChat';
  static const String mechanicChat = '/mechanicChat';
  static const String editProfile = '/editProfile';
  static const String emergency = '/emergency';
  static const String myOrders = '/myOrders';
  static const String orders = '/orders';
  static const String scheduleHistory = '/schedule_history';
  static const String myCar = '/myCar';
  static const String assignedJobs = '/assignedJobs';
  static const String mechanicSettings = '/mechanicSettings';
  static const String mechanicSchedule = '/mechanicSchedule';
  static const String emergencyResponse='/emergencyResponse';
  static const String serviceResponse='/serviceResponse';
  static const String carParts='/carParts';

  static final List<GetPage> pages = [
    GetPage(name: registration, page: () => RegistrationPage()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: mechanic, page: () => MechanicHomeScreen()),
    GetPage(name: serviceRequests, page: () => ServiceRequestScreen()),
    GetPage(name: mechanicChat, page: () => MechanicChatScreen()),
    GetPage(name: customerChat, page: () => CustomerChatScreen()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: emergency, page: () => EmergencyRequestScreen()),
    GetPage(name: myOrders, page: () => MyOrdersScreen()),
    GetPage(name: orders, page: () => OrdersScreen()),
    GetPage(name: scheduleHistory, page: () => ScheduleHistoryScreen()),
    GetPage(name: myCar, page: () => AddCarScreen()),
    GetPage(name: AppRoute.assignedJobs, page: () => AssignedJobsScreen(),),
    GetPage(name: AppRoute.mechanicSettings, page: () => MechanicSettingsScreen(),),
    GetPage(name: AppRoute.mechanicSchedule, page: () => MechanicScheduleScreen(),),
    GetPage(name: AppRoute.emergencyResponse, page: () => EmergencyRespondScreen(),),
    GetPage(name: AppRoute.serviceResponse, page: () => ServiceResponseScreen(),),
    GetPage(name: AppRoute.carParts, page: () => CarPartsScreen(),),
  ];
}

