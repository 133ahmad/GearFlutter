class Order {
  final String id;
  final String partName;
  final double price;
  final DateTime orderDate;
  final String status;
  final bool isDelivered;
  final String? trackingNumber;
  final bool isCanceled;

  Order({
    required this.id,
    required this.partName,
    required this.price,
    required this.orderDate,
    required this.status,
    required this.isDelivered,
    this.trackingNumber,
    required this.isCanceled,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      partName: json['part_name'],
      price: json['price'].toDouble(),
      orderDate: DateTime.parse(json['order_date']),
      status: json['status'],
      isDelivered: json['is_delivered'],
      trackingNumber: json['tracking_number'],
      isCanceled: json['is_canceled'],

    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'part_name': partName,
      'price': price,
      'order_date': orderDate.toIso8601String(),
      'status': status,
      'is_delivered': isDelivered,
      'tracking_number': trackingNumber,
      'is_canceled': isCanceled,
    };
  }
}