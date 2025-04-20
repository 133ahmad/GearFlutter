class Mechanic {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String specialization;
  final int experience;
  final String rating;
  final String availability;

  Mechanic({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.specialization,
    required this.experience,
    required this.rating,
    required this.availability,
  });

  factory Mechanic.fromJson(Map<String, dynamic> json) {
    return Mechanic(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      location: json['location'],
      specialization: json['specialization'],
      experience: json['experience'],
      rating: json['rating'],
      availability: json['availability'],
    );
  }
}
