import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/route.dart';

class ShopMenuItem extends StatelessWidget {
  final String name;
  final int price;
  final String? image;

  const ShopMenuItem({
    super.key,
    required this.name,
    required this.price,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Image.network(
              image ?? "https://picsum.photos/200",
              fit: BoxFit.cover,
              width: 50,
            ),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${price.toString()}THB")
            ]),
            const Spacer(),
            IconButton(
                onPressed: () => Get.toNamed(RoutePath.editMenuPath),
                icon: const Icon(Icons.edit)),
            const IconButton(onPressed: null, icon: Icon(Icons.delete))
          ],
        ));
  }
}
