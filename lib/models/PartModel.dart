class PartModel {
  final int id;
  final String name;
  final double price;

  PartModel({required this.id, required this.name, required this.price});

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
    );
  }
}
