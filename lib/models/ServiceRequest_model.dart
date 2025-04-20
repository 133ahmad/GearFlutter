class ServiceRequest {
  final int id;
  final int serviceTypeId;
  final String status;
  final DateTime appointmentTime;
  final int customerId;
  final int mechanicId;

  ServiceRequest({
    required this.id,
    required this.serviceTypeId,
    required this.status,
    required this.appointmentTime,
    required this.customerId,
    required this.mechanicId,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'],
      serviceTypeId: json['service_type_id'],
      status: json['status'],
      appointmentTime: DateTime.parse(json['appointment_time']),
      customerId: json['customer_id'],
      mechanicId: json['mechanic_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_type_id': serviceTypeId,
      'status': status,
      'appointment_time': appointmentTime.toIso8601String(),
      'customer_id': customerId,
      'mechanic_id': mechanicId,
    };
  }
}
