import 'dart:convert';

import 'package:get/get.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class ShopManageController extends GetxController {
  final shopList = <Shop>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getShopList();
  }

  _clearShopList() {
    shopList.clear();
  }

  Future<void> getShopList() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final data = json.decode(response.body);
    if (shopList.isNotEmpty) {
      _clearShopList();
    }
    for (final shop in data['shops']) {
      shopList.add(Shop.fromJson(shop));
    }
    shopList.refresh();
  }

  Future<void> deleteShop(int shopId) async {
    try {
      await Requests.delete(
        '${Config.getServerUrl()}/api/v1/shops/$shopId',
        headers: {
          'Content-Type': 'application/json',
        },
      );
      await getShopList();
    } on HTTPException catch (err) {
      Get.snackbar("Can't delete shop", err.response.body);
      return Future.error(err.response.body);
    }
    return;
  }
}
