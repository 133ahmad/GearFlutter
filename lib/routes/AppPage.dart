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
import 'package:gear/views/Customer_chat.dart';
import 'package:gear/views/Mechanic_chat.dart';

class AppRoute {
  static const String registration = '/';
  static const String login = '/login';
  static const String first = '/first';
  static const String mechanic = '/mechanic';
  static const String serviceRequests = '/service_requests';
  static const String customerChat ='/Customerchat';
  static const String mechanicChat='/mechanicchat';
  static const String editProfile = '/editProfile';
  static const String emergency = '/Emergency';
  static const String myOrders = 'Myorders';
  static const String orders = 'orders';
  static const scheduleHistory = '/schedule-history';

  static final List<GetPage> pages = [
    GetPage(name: registration,
        page: () => RegistrationPage()),
    GetPage(name: login,
        page: () => LoginPage()),
    GetPage(name: first,
        page: () => HomeScreen()),
    GetPage(name: mechanic,
        page: () => MechanicHomeScreen()),
    GetPage(name: serviceRequests,
        page: () => ServiceRequestScreen()),
    GetPage(name: mechanicChat,
        page: () => ChatPage()),
    GetPage(name: customerChat,
        page: ()=>ChatPage()),// This will navigate to the correct screen
    GetPage(name: editProfile,
        page: () => EditProfileScreen()),
    GetPage(name: emergency,
        page: () => EmergencyRequestScreen()),
    GetPage(name: myOrders,
        page: () => MyOrdersScreen()),
    GetPage(name: orders,
        page: () => OrdersScreen()),
    GetPage(name: scheduleHistory,
        page: () => ScheduleHistoryScreen()),
  ];
}
