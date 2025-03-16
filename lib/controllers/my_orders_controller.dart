import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:gear/models/order_model.dart';

class MyOrdersController extends GetxController {
  var isLoading = false.obs;
  var orders = <OrderModel>[].obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      var response = await Dio().get('https://your-laravel-api.com/api/my-orders');

      if (response.statusCode == 200) {
        orders.value = (response.data as List).map((e) => OrderModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch orders');
    } finally {
      isLoading(false);
    }
  }
}
