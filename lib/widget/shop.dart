import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

import '../models/shop.dart';

class ShopWidget extends StatelessWidget {
  final Shop shop;
  final Function()? onDelete;

  const ShopWidget({
    super.key,
    required this.shop,
    this.onDelete,
  });

  _toManageEditShop() {
    Get.toNamed(RoutePath.toPath(RoutePath.shopManageEditPath, {
      'shopId': shop.id.toString(),
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _toManageEditShop,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          child: shop.image != null
              ? Image.memory(base64.decode(shop.image!))
              : const CircleAvatar(),
        ),
      ),
      trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
          )),
      title: Text(shop.name),
      subtitle: Text(shop.description ?? ''),
      dense: false,
    );
  }
}
