import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/widget/shop/shop_menu_item.dart';

class MenuOwnerView extends StatelessWidget {
  const MenuOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop Menu"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: null,
                child: const Icon(Icons.add),
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShopMenuItem(name: 'name', price: 100),
                ShopMenuItem(name: 'ข้าวมันไก่', price: 30)
              ],
            )),
      ),
    );
  }
}
