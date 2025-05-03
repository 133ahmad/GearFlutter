class ProfileModel {
  String? name;
  String? email;
  String? phone;
  String profileImageUrl;  // This will store the profile image URL or path
  String? city;

  // Constructor for creating a ProfileModel instance
  ProfileModel({
    this.name,
    this.email,
    this.phone,
    this.profileImageUrl = 'assets/default_profile.png', // Default profile image
    this.city,
  });

  // Factory method to create a ProfileModel instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImageUrl: json['profileImage'] ?? 'assets/default_profile.png', // Default if null
      city: json['city'],
    );
  }

  // Method to convert the ProfileModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImageUrl,
      'city': city,
    };
  }
}
