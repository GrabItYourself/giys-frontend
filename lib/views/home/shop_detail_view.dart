import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/models/shop.dart';

class ShopDetailView extends StatelessWidget {
  final Shop shop = Get.arguments;
  ShopDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop")),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: shop.image != null
                        ? Image.memory(base64.decode(shop.image!),
                            fit: BoxFit.cover)
                        : const CircleAvatar(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Shop Name",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      Text(shop.name),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Description",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      Text(shop.description ?? ""),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Location",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      Text(shop.location ?? ""),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("Contact",
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.3))),
                      Text(shop.contact ?? ""),
                    ],
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))),
    );
  }
}
