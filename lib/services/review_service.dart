import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gear/models/review_model.dart';

class ReviewService {
  final String apiUrl = 'http://192.168.0.102:8000/api';

  // Fetch reviews
  Future<List<Review>> fetchReviews(int customerId) async {
    final response = await http.get(Uri.parse('$apiUrl/reviews?customer_id=$customerId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Review.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  // Store review
  Future<Review> storeReview(Review review) async {
    final response = await http.post(
      Uri.parse('$apiUrl/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 201) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit review');
    }
  }

  // Update review
  Future<Review> updateReview(Review review) async {
    final response = await http.put(
      Uri.parse('$apiUrl/reviews/${review.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );

    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update review');
    }
  }
}
