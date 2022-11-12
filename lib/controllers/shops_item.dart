import 'dart:developer';

import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:giys_frontend/models/shop_item.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';

class ShopItemsController extends GetxController {
  var shopItemsList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      await getAllShopItems(1);
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
  }

  getAllShopItems(int shopId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/items',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log(response.toString());
    response.raiseForStatus();
    final data = AllShopItemsResponse.fromJson(response.json());
    shopItemsList.value = data.items;
  }
}
