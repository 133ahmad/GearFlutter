class OrderModel {
  final int id;
  final String partName;
  final String orderDate;
  final double price;

  OrderModel({required this.id, required this.partName, required this.orderDate, required this.price});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      partName: json['part_name'],
      orderDate: json['order_date'],
      price: double.parse(json['price'].toString()),
    );
  }
}
