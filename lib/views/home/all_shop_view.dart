import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/shop_get.dart';
import 'package:giys_frontend/widget/scaffold.dart';

class AllShopView extends StatelessWidget {
  AllShopView({super.key});
  final shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Shops",
        back: true,
        body: SafeArea(child: GetX<ShopController>(
          builder: ((controller) {
            return Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.shopList.length,
                  itemBuilder: (context, index) {
                    final shop = controller.shopList[index];
                    return ListTile(
                      leading: shop.image != null
                          ? Image.memory(
                              base64Decode(shop.image),
                              fit: BoxFit.fitWidth,
                            )
                          : SizedBox(
                              width: 50,
                              height: 50,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              )),
                            ),
                      title: Text(shop.name),
                      subtitle: Text(shop.description ?? ""),
                      onTap: () {
                        Get.toNamed(RoutePath.shopMenuPath, arguments: shop);
                      },
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () async {
                    shopController.getAllShop();
                  },
                  child: const Text("Resend")),
            ]);
          }),
        )));
  }
}
