class Review {
  final int id;
  final int customerId;
  final int mechanicId;
  final int serviceRequestId;
  final int rating;
  final String? comment;
  final DateTime date;

  Review({
    required this.id,
    required this.customerId,
    required this.mechanicId,
    required this.serviceRequestId,
    required this.rating,
    this.comment,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      customerId: json['customer_id'],
      mechanicId: json['mechanic_id'],
      serviceRequestId: json['service_request_id'],
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'mechanic_id': mechanicId,
      'service_request_id': serviceRequestId,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
