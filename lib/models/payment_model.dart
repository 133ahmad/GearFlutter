class Payment {
  final int id;
  final double amount;
  final String method;
  final String status;
  final DateTime transactionDate;
  final int customerId;
  final int serviceRequestId;

  Payment({
    required this.id,
    required this.amount,
    required this.method,
    required this.status,
    required this.transactionDate,
    required this.customerId,
    required this.serviceRequestId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      amount: json['amount'].toDouble(),
      method: json['method'],
      status: json['status'],
      transactionDate: DateTime.parse(json['transaction_date']),
      customerId: json['customer_id'],
      serviceRequestId: json['service_request_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'method': method,
      'status': status,
      'transaction_date': transactionDate.toIso8601String(),
      'customer_id': customerId,
      'service_request_id': serviceRequestId,
    };
  }
}
