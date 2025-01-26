class user{
  final String name;
  final String phonenb;
  final String country;
  final String age;
  user({required this.name, required this.age, required this.country,required this.phonenb});
  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      name: json['name'],
      age: json['age'],
      phonenb: json['phonenb'],
      country: json['country'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phonenb': phonenb,
      'country':country,
    };
  }

}
