import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyRespondScreen extends StatelessWidget {

  final List<Map<String, String>> emergencyRequests = [
    {
      'id': '1',
      'location': '123 Main St, City A',
      'description': 'Car breakdown on the highway',
      'status': 'Pending',
    },
    {
      'id': '2',
      'location': '456 Elm St, City B',
      'description': 'Flat tire on the roadside',
      'status': 'Pending',
    },
    {
      'id': '3',
      'location': '789 Oak St, City C',
      'description': 'Engine overheating',
      'status': 'Pending',
    },
  ];

  // Function to handle responding to an emergency request
  void _respondToRequest(String requestId) {
    // Update the status of the request
    final request = emergencyRequests.firstWhere((req) => req['id'] == requestId);
    request['status'] = 'Responded';

    // Show a confirmation message
    Get.snackbar(
      'Response Sent',
      'You have responded to Emergency Request #$requestId',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Requests'),
      ),
      body: ListView.builder(
        itemCount: emergencyRequests.length,
        itemBuilder: (context, index) {
          final request = emergencyRequests[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text('Emergency Request #${request['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location: ${request['location']}'),
                  Text('Description: ${request['description']}'),
                  SizedBox(height: 5),
                  Text(
                    'Status: ${request['status']}',
                    style: TextStyle(
                      color: request['status'] == 'Pending' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: request['status'] == 'Pending'
                  ? ElevatedButton(
                onPressed: () => _respondToRequest(request['id']!),
                child: Text('Respond'),
              )
                  : Text(
                'Responded',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}