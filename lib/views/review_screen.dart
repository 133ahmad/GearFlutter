import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/models/review_model.dart';
import 'package:gear/controllers/review_controller.dart';

class ReviewPage extends StatelessWidget {
  final ReviewController reviewController = Get.put(ReviewController());
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Review')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: ratingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Rating (1-5)'),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final review = Review(
                  id: 0, // Assuming 0 for new review, will be assigned in the backend
                  customerId: 1, // Your customer ID
                  mechanicId: 1, // Your mechanic ID
                  serviceRequestId: 1, // Your service request ID
                  rating: int.parse(ratingController.text),
                  comment: commentController.text,
                  date: DateTime.now(),
                );
                reviewController.submitReview(review);
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
