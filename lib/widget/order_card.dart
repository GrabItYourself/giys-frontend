import 'package:flutter/material.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onCancel,
  });

  final Order order;
  final Future<void> Function() onCancel;

  showAlertDialog() {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes, cancel it"),
      onPressed: () {
        onCancel();
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Cancel Order"),
      content: const Text("Would you like to cancel this order?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    Get.dialog(alert);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2),
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
                order.id.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(order.status),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              if (order.status == "IN_QUEUE") ...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () => showAlertDialog(),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}
