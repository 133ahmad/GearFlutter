import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/parts_controller.dart';
import 'package:gear/controllers/my_orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  final PartsController partsController = Get.put(PartsController(), permanent: true);
  final MyOrdersController myOrdersController = Get.put(MyOrdersController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Car Parts')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search for car parts',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                // Implement search filter logic if needed
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (partsController.parts.isEmpty) {
                  return Center(child: Text('No parts available.'));
                }

                return ListView.builder(
                  itemCount: partsController.parts.length,
                  itemBuilder: (context, index) {
                    final part = partsController.parts[index];

                    // Ensure price is correctly formatted
                    String formattedPrice = part.price.toStringAsFixed(2);

                    return ListTile(
                      title: Text(part.name),
                      subtitle: Text('${part.description}\nPrice: \$${formattedPrice}'),
                      trailing: Icon(Icons.shopping_cart),
                      onTap: () {
                        myOrdersController.addOrder(part.name, part.price);
                        Get.snackbar('Success', 'Part added to My Orders');
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
