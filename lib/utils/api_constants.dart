class ApiConstants {
  // Base URL configuration
  static const String _baseUrl = 'http://192.168.0.102:8000/api';

  // Authentication endpoints
  static String get login => '$_baseUrl/login';
  static String get logout => '$_baseUrl/logout';

  // Customer endpoints
  static String get registerCustomer => '$_baseUrl/customer/register/store';
  static String get updateCustomerProfile => '$_baseUrl/customer/profile/edit';
  static String get customerServiceRequests => '$_baseUrl/customer/service-request/store';
  static String get customerEmergencyRequests => '$_baseUrl/customer/emergency-request/store';

  // Mechanic endpoints
  static String get mechanics => '$_baseUrl/mechanics';
  static String get registerMechanic => '$_baseUrl/mechanic/register/store';
  static String get updateMechanicProfile => '$_baseUrl/mechanic/profile/edit';
  static String get mechanicServiceRequests => '$_baseUrl/mechanic/service-request';
  static String acceptServiceRequest(int id) => '$_baseUrl/mechanic/service-request/accept/$id';
  static String declineServiceRequest(int id) => '$_baseUrl/mechanic/service-request/decline/$id';

  // Service Types
  static String get serviceTypes => '$_baseUrl/mechanic/service-type/store';
  static String updateServiceType(int id) => '$_baseUrl/mechanic/service-type/update/$id';
  static String deleteServiceType(int id) => '$_baseUrl/mechanic/service-type/delete/$id';

  // Emergency Requests
  static String acceptEmergencyRequest(int id) => '$_baseUrl/mechanic/emergency-request/accept/$id';
  static String declineEmergencyRequest(int id) => '$_baseUrl/mechanic/emergency-request/decline/$id';
  static String updateEmergencyRequest(int id) => '$_baseUrl/mechanic/emergency-request/update/$id';
  static String deleteEmergencyRequest(int id) => '$_baseUrl/mechanic/emergency-request/delete/$id';

  // Timeout configuration
  static const int connectionTimeout = 10000; // 10 seconds
  static const int receiveTimeout = 10000; // 10 seconds
}