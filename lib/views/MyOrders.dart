import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/my_orders_controller.dart';

class MyOrdersScreen extends StatelessWidget {
  final MyOrdersController controller = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (controller.orders.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return Card(
                child: ListTile(
                  title: Text(order.partName),
                  subtitle: Text('Ordered on: ${order.orderDate.toLocal()}'),
                  trailing: Text('\$${order.price}'),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
