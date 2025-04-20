import 'package:get/get.dart';
import 'package:gear/models/payment_model.dart';
import 'package:gear/services/payment_service.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;

  final PaymentService paymentService = PaymentService();

  // Submit payment
  Future<void> submitPayment(Payment payment) async {
    try {
      isLoading(true);
      await paymentService.storePayment(payment);
    } catch (e) {
      print('Error submitting payment: $e');
    } finally {
      isLoading(false);
    }
  }
}
