import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/models/shop.dart';

class ShopDetailView extends StatelessWidget {
  final Shop shop = Get.arguments;
  ShopDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Detail")),
      body: Center(
        child: Column(
          children: [
            shop.image != null
                ? Image.network(
                    shop.image!,
                    fit: BoxFit.fitWidth,
                  )
                : Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.fitWidth,
                  ),
            Text(shop.name),
            Text(shop.description ?? ""),
            Text(shop.location ?? ""),
            Text(shop.contact ?? ""),
          ],
        ),
      ),
    );
  }
}
