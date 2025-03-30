import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/parts_controller.dart';
import 'addPartScreen.dart';

class CarPartsScreen extends StatelessWidget {
  final PartsController partsController = Get.put(PartsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Parts for Sale')),
      body: Obx(() {
        return partsController.parts.isEmpty
            ? Center(child: Text('No parts listed yet. Tap + to add parts.'))
            : ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: partsController.parts.length,
          itemBuilder: (context, index) {
            final part = partsController.parts[index];
            return Card(
              child: ListTile(
                title: Text(part.name),
                subtitle: Text('${part.description} - \$${part.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => partsController.removePart(index),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPartScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
