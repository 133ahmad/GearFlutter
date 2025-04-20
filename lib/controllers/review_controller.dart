import 'package:get/get.dart';
import 'package:gear/models/review_model.dart';
import 'package:gear/services/review_service.dart';

class ReviewController extends GetxController {
  var reviews = <Review>[].obs;
  var isLoading = false.obs;

  final ReviewService reviewService = ReviewService();

  // Fetch reviews
  Future<void> fetchReviews(int customerId) async {
    try {
      isLoading(true);
      reviews.value = await reviewService.fetchReviews(customerId);
    } catch (e) {
      print('Error fetching reviews: $e');
    } finally {
      isLoading(false);
    }
  }

  // Submit review
  Future<void> submitReview(Review review) async {
    try {
      isLoading(true);
      await reviewService.storeReview(review);
      fetchReviews(review.customerId); // Refresh the reviews list after submission
    } catch (e) {
      print('Error submitting review: $e');
    } finally {
      isLoading(false);
    }
  }

  // Update review
  Future<void> updateReview(Review review) async {
    try {
      isLoading(true);
      await reviewService.updateReview(review);
      fetchReviews(review.customerId); // Refresh the reviews list after update
    } catch (e) {
      print('Error updating review: $e');
    } finally {
      isLoading(false);
    }
  }
}
