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
      final shopListData = await getAllShopItems(1);
      shopItemsList.value = shopListData.items;
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
  }

  Future<AllShopItemsResponse> getAllShopItems(int shopId) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$shopId/items',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log(response.toString());
    response.raiseForStatus();
    return AllShopItemsResponse.fromJson(response.json());
  }
}
