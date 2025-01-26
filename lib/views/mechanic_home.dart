import 'package:flutter/material.dart';

class MechanicHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Button to check reservations
            ElevatedButton(
              onPressed: () {
                // Navigate to the reservations page
                Navigator.pushNamed(context, '/reservations');
              },
              child: Text('Check Reservations'),
            ),
            SizedBox(height: 20),
            // Button to chat with people
            ElevatedButton(
              onPressed: () {
                // Navigate to the chat page
                Navigator.pushNamed(context, '/chat');
              },
              child: Text('Chat with People'),
            ),
            SizedBox(height: 20),
            // Add more buttons for other functionality
            ElevatedButton(
              onPressed: () {
                // Navigate to another functionality
              },
              child: Text('Other Functionality'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MechanicHomeScreen(),
    routes: {
      '/reservations': (context) => ReservationsPage(),
      '/chat': (context) => ChatPage(),
      // Add other routes here
    },
  ));
}

// Placeholder pages for navigation
class ReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservations')),
      body: Center(child: Text('Reservations Page')),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(child: Text('Chat Page')),
    );
  }
}
