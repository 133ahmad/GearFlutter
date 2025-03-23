import 'package:flutter/material.dart';

class CarPartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Parts'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Engine'),
            subtitle: Text('Engine components and parts'),
            onTap: () {
              // Navigate to engine parts details
            },
          ),
          ListTile(
            title: Text('Transmission'),
            subtitle: Text('Transmission components and parts'),
            onTap: () {
              // Navigate to transmission parts details
            },
          ),
          ListTile(
            title: Text('Brakes'),
            subtitle: Text('Brake components and parts'),
            onTap: () {
              // Navigate to brake parts details
            },
          ),
          ListTile(
            title: Text('Suspension'),
            subtitle: Text('Suspension components and parts'),
            onTap: () {
              // Navigate to suspension parts details
            },
          ),
        ],
      ),
    );
  }
}