import 'package:flutter/material.dart';

class Message {
  final String senderName;
  final String senderProfile;
  final String message;

  Message({required this.senderName, required this.senderProfile, required this.message});
}

class ChatController extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
        senderName: 'John Doe',
        senderProfile: 'https://example.com/profile1.jpg',
        message: 'Hey, How are you?'),
    Message(
        senderName: 'Jane Smith',
        senderProfile: 'https://example.com/profile2.jpg',
        message: 'I am good, thanks! How about you?'),
  ];

  List<Message> get messages => _messages;

  // Function to send a message
  void sendMessage(String messageText) {
    if (messageText.isNotEmpty) {
      _messages.add(Message(
          senderName: 'Me',
          senderProfile: 'https://example.com/profile_me.jpg',
          message: messageText));
      notifyListeners(); // Notify listeners when a message is added
    }
  }
}
