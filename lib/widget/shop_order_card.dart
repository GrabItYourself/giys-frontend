import 'package:flutter/material.dart';
import 'package:giys_frontend/models/order.dart';
import 'package:get/get.dart';

class ShopOrderCard extends StatelessWidget {
  const ShopOrderCard({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onReady,
    required this.onComplete,
  });

  final Order order;
  final Future<void> Function() onCancel;
  final Future<void> Function() onReady;
  final Future<void> Function() onComplete;

  showCancelAlertDialog() {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
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

  showReadyAlertDialog() {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        onReady();
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Mark order as ready"),
      content: const Text("Would you like to mark this order as ready?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    Get.dialog(alert);
  }

  showCompleteAlertDialog() {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Get.back();
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        onComplete();
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Complete Order"),
      content: const Text("Would you like to complete this order?"),
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
              if (order.status == "Ready") ...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => showCompleteAlertDialog(),
                    child: const Text("Complete"),
                  ),
                ),
              ],
              if (order.status == "IN_QUEUE") ...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () => showReadyAlertDialog(),
                    child: const Text("Ready"),
                  ),
                ),
              ],
              if (order.status == "IN_QUEUE") ...[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () => showCancelAlertDialog(),
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
