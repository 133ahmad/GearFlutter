import 'package:get/get.dart';
import 'package:gear/models/order_model.dart';
import 'package:gear/services/api_service.dart';

class MyOrdersController extends GetxController {
  final orders = <Order>[].obs;
  final isLoading = true.obs;
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading(true);
      final response = await _apiService.get('/orders');
      if (response.statusCode == 200) {
        final ordersList = (response.data as List)
            .map((orderJson) => Order.fromJson(orderJson))
            .toList();
        orders.assignAll(ordersList);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      isLoading(true);
      final response = await _apiService.delete('/orders/$orderId');
      if (response.statusCode == 200 || response.statusCode == 204) {
        orders.removeWhere((o) => o.id == orderId);
        Get.snackbar('Success', 'Order cancelled');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to cancel order: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addOrder(String name, double price) async {
    try {
      isLoading(true);
      final response = await _apiService.post('/orders', {
        'name': name,
        'price': price,
      });
      if (response.statusCode == 201) {
        final newOrder = Order.fromJson(response.data);
        orders.add(newOrder);
        Get.snackbar('Success', 'Order added successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add order: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}