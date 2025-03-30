import 'package:get/get.dart';

class Order {
  final String partName;
  final double price;
  final DateTime orderDate;

  Order({required this.partName, required this.price, required this.orderDate});
}

class MyOrdersController extends GetxController {
  var orders = <Order>[].obs;
  var isLoading = false.obs;

  void addOrder(String partName, double price) {
    orders.add(Order(partName: partName, price: price, orderDate: DateTime.now()));
  }
}
