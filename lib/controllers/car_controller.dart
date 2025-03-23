import 'package:get/get.dart';
import 'package:gear/models/car_model.dart';

class CarController extends GetxController {
  var userCar = Rxn<Car>();

  void updateCar(Car newCar) {
    userCar.value = newCar;
  }
}
