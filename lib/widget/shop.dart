import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';

import '../models/shop.dart';

class ShopWidget extends StatelessWidget {
  final Shop shop;

  const ShopWidget({
    super.key,
    required this.shop,
  });

  _toManageEditShop() {
    Get.offAndToNamed(RoutePath.toPath(RoutePath.shopManageEditPath, {
      'shopId': shop.id.toString(),
    }));
  }

  _onTab() {
    _toManageEditShop();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _onTab,
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
          onPressed: _toManageEditShop,
          icon: const Icon(
            Icons.edit,
          )),
      title: Text(shop.name),
      subtitle: Text(shop.description ?? ''),
      dense: false,
    );
  }
}
