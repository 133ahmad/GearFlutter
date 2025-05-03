import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gear/models/payment_model.dart';

class PaymentService {
  final String apiUrl = 'http://192.168.0.102:8000/api';

  // Store payment
  Future<Payment> storePayment(Payment payment) async {
    final response = await http.post(
      Uri.parse('$apiUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payment.toJson()),
    );

    if (response.statusCode == 201) {
      return Payment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit payment');
    }
  }
}
