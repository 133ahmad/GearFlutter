import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/chat_controller.dart';

class MechanicChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController()); // Ensure correct controller usage

    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Chat'),
      ),
      body: Column(
        children: [
          // Chat messages display
          Expanded(
            child: GetBuilder<ChatController>(
              builder: (_) {
                return ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    if (message.senderRole == 'mechanic') {
                      return ListTile(
                        title: Text(message.senderName),
                        subtitle: Text(message.message),
                        trailing: Text(message.timestamp),
                      );
                    }
                    return SizedBox.shrink(); // Don't show messages for non-mechanic roles
                  },
                );
              },
            ),
          ),
          // Text input to send message
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Type a message...'),
                    onChanged: (text) {},
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Send message as a mechanic
                    controller.sendMessage("Mechanic's message"); // Sending message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
