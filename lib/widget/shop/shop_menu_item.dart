import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/controllers/crud_item.dart';
import 'package:giys_frontend/models/shop_item.dart';

import '../../config/route.dart';

class ShopMenuItem extends StatelessWidget {
  final String name;
  final int price;
  final String? image;
  final int shopId;
  final ShopItem shopItem;
  final CRUDItemController crudItemController = CRUDItemController();

  ShopMenuItem({
    super.key,
    required this.name,
    required this.price,
    this.image,
    required this.shopId,
    required this.shopItem,
  });

  @override
  Widget build(BuildContext context) {
    //TODO add add/edit/delete capabilities
    return Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            image != null
                ? Image.memory(base64.decode(image!), fit: BoxFit.cover)
                : Image.network(
                    "https://picsum.photos/200",
                    fit: BoxFit.cover,
                    width: 50,
                  ),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("${price.toString()} THB")
            ]),
            const Spacer(),
            IconButton(
                onPressed: () => Get.toNamed(
                    RoutePath.editMenuPath
                        .replaceAll(':shopId', shopId.toString())
                        .replaceAll(":shopItemId", shopItem.id.toString()),
                    arguments: [shopId, shopItem, "EDIT"]),
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  crudItemController.deleteItem(shopId, shopItem.id);
                },
                icon: const Icon(Icons.delete))
          ],
        ));
  }
}
