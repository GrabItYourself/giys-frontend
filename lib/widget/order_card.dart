import 'package:flutter/material.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/widget/order_alert_dialog.dart';

import '../config/route.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.isOwner,
    required this.order,
    required this.onCancel,
    this.onReady,
    this.onComplete,
  });

  final bool isOwner;
  final Order order;
  final Future<void> Function() onCancel;
  final Future<void> Function()? onReady;
  final Future<void> Function()? onComplete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        RoutePath.orderDetailPath,
        arguments: {
          'order': order,
        },
      ),
      child: Card(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Row(
          children: [
            Image.network(
              "https://picsum.photos/200",
              fit: BoxFit.cover,
              width: 100,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.shop!.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Order ID: ${order.id}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 125, 125, 125)),
                ),
                const SizedBox(height: 8),
                Text(
                  order.status,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 125, 125, 125)),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                if (isOwner && order.status == "READY") ...[
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => Get.dialog(
                        OrderAlertDialog(
                          onContinue: onComplete!,
                          title: "Complete Order",
                          content: "Would you like to complete this order?",
                        ),
                      ),
                      child: const Text("Complete"),
                    ),
                  ),
                ],
                if (isOwner && order.status == "IN_QUEUE") ...[
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => Get.dialog(
                        OrderAlertDialog(
                          onContinue: onReady!,
                          title: "Mark order as ready",
                          content:
                              "Would you like to mark this order as ready?",
                        ),
                      ),
                      child: const Text("Ready"),
                    ),
                  ),
                ],
                if (order.status == "IN_QUEUE") ...[
                  SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      onPressed: () => Get.dialog(
                        OrderAlertDialog(
                          onContinue: onCancel,
                          title: "Cancel Order",
                          content: "Would you like to cancel this order?",
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
