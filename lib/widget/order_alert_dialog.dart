import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderAlertDialog extends StatelessWidget {
  const OrderAlertDialog({
    super.key,
    required this.onContinue,
    required this.title,
    required this.content,
  });

  final Future<void> Function() onContinue;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () {
            onContinue();
            Get.back();
          },
        ),
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
