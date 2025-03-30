import 'package:get/get.dart';

class Part {
  final String name;
  final String description;
  final double price;

  Part({required this.name, required this.description, required this.price});
}

class PartsController extends GetxController {
  var parts = <Part>[].obs;

  void addPart(String name, String description, double price) {
    parts.add(Part(name: name, description: description, price: price));
  }

  void removePart(int index) {
    parts.removeAt(index);
  }
}
