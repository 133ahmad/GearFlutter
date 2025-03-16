class Message {
  final String senderName;
  final String senderRole; // Either "customer" or "mechanic"
  final String message;
  final String timestamp;

  Message({
    required this.senderName,
    required this.senderRole,
    required this.message,
    required this.timestamp,
  });
}
