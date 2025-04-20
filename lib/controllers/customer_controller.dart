import 'package:get/get.dart';
import 'package:gear/models/Customer.dart';
import 'package:gear/services/Customer_services.dart';
class CustomerController extends GetxController {
  var customer = Rxn<Customer>();
  var isLoading = false.obs;

  final CustomerService customerService = CustomerService();

  // Fetch customer profile
  Future<void> fetchCustomerProfile(int id) async {
    try {
      isLoading(true);
      customer.value = await customerService.getCustomerProfile(id);
    } catch (e) {
      print('Error fetching customer profile: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update customer profile
  Future<void> updateCustomerProfile(int id, Customer updatedCustomer) async {
    try {
      isLoading(true);
      customer.value = await customerService.updateCustomerProfile(id, updatedCustomer);
    } catch (e) {
      print('Error updating customer profile: $e');
    } finally {
      isLoading(false);
    }
  }
}
