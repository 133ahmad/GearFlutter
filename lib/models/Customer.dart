class Customer {
  final String name;
  final String email;
  final String phone;
  final String location;
  final DateTime registrationDate;

  Customer({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.registrationDate,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      registrationDate: DateTime.parse(json['registration_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'registration_date': registrationDate.toIso8601String(),
    };
  }
}
