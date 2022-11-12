import 'dart:convert';

import 'package:get/get.dart';
import 'package:giys_frontend/models/shop.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class ShopManageController extends GetxController {
  final shopList = <Shop>[].obs;

  @override
  void onInit() async {
    await getShopList();
    super.onInit();
  }

  Future<void> getShopList() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    final data = json.decode(response.body);
    shopList.value =
        data["shops"].map<Shop>((shop) => Shop.fromJson(shop)).toList();
    print(shopList);
  }
}
