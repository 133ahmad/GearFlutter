import 'package:get/get.dart';
import 'package:gear/models/message_model.dart';

class ChatController extends GetxController {
  var messages = <Message>[];

  // Function to send a message
  void sendMessage(String text, String senderName, String senderRole) {
    final timestamp = DateTime.now().toString();

    // Add the new message to the list
    messages.add(Message(
      senderName: senderName,
      senderRole: senderRole,
      message: text,
      timestamp: timestamp,
    ));

    // Update the state
    update();
  }
}
