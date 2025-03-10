import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package
import 'package:gear/controllers/chat_controller.dart'; // Import the controller

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional Chat'),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: Consumer<ChatController>(
              builder: (context, chatController, child) {
                return ListView.builder(
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessageItem(
                      message: chatController.messages[index],
                    );
                  },
                );
              },
            ),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final messageText = _controller.text;
                    if (messageText.isNotEmpty) {
                      // Using the ChatController to send the message
                      context.read<ChatController>().sendMessage(messageText);
                      _controller.clear(); // Clear the input field
                    }
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

class ChatMessageItem extends StatelessWidget {
  final Message message;

  ChatMessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(message.senderProfile),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            message.senderName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '12:30 PM', // This can be dynamic based on the message timestamp
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          message.message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
