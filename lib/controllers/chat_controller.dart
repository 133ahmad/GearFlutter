import 'package:get/get.dart';
import 'package:gear/models/message_model.dart';

class ChatController extends GetxController { // <-- Fix: extend GetxController
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  // Method to send a message
  void sendMessage(String text) {
    _messages.add(
      Message(
        senderName: "Mechanic",  // Static example for now, change as needed
        senderRole: 'mechanic',  // Define the sender role as mechanic
        message: text,
        timestamp: DateTime.now().toString(),  // Add timestamp
      ),
    );
    update();  // Notify listeners (GetBuilder in the UI)
  }
}
