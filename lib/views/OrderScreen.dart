import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  final OrdersController controller = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Car Parts'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                labelText: 'Search for car parts',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => controller.searchParts(query),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.parts.isEmpty) {
                  return Center(child: Text('No parts found.'));
                }

                return ListView.builder(
                  itemCount: controller.parts.length,
                  itemBuilder: (context, index) {
                    final part = controller.parts[index];
                    return ListTile(
                      title: Text(part.name),
                      subtitle: Text('Price: \$${part.price}'),
                      trailing: Icon(Icons.shopping_cart),
                      onTap: () {
                        // Navigate to part details
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
