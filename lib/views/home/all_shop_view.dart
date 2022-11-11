import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/controllers/auth.dart';
import 'package:giys_frontend/controllers/shops.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:giys_frontend/views/home/shop_menu_view.dart';
import 'package:giys_frontend/widget/scaffold.dart';
import 'package:http/http.dart' as http;

class AllShopView extends StatelessWidget {
  AllShopView({super.key});
  final shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: "Home",
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
                          ? Image.network(
                              shop.image!,
                              fit: BoxFit.fitWidth,
                            )
                          : Image.network(
                              "https://picsum.photos/200",
                              fit: BoxFit.fitWidth,
                            ),
                      title: Text(shop.name),
                      subtitle: Text(shop.description ?? ""),
                      onTap: () {
                        Get.toNamed(RoutePath.shopMenuPath, arguments: shop);
                      },
                    );
                  },
                ),
              )
            ]);
          }),
        )));
  }
}
