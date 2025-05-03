import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gear/controllers/my_orders_controller.dart';
import 'package:gear/models/order_model.dart';
import 'package:intl/intl.dart';

class MyOrdersScreen extends StatelessWidget {
  final MyOrdersController controller = Get.put(MyOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchOrders,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return Center(child: Text('No orders found'));
        }
        return ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Icon(
                  order.isDelivered ? Icons.check_circle : Icons.pending,
                  color: order.isDelivered ? Colors.green : Colors.orange,
                ),
                title: Text(order.partName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ordered: ${DateFormat('MMM dd, yyyy').format(order.orderDate)}'),
                    Text('Status: ${order.status}'),
                    if (order.trackingNumber != null)
                      Text('Tracking: ${order.trackingNumber}'),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${order.price.toStringAsFixed(2)}'),
                    if (!order.isDelivered && !order.isCanceled)
                      TextButton(
                        child: Text('Cancel', style: TextStyle(color: Colors.red)),
                        onPressed: () => controller.cancelOrder(order.id),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

