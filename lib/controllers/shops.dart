import 'dart:developer';

import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../models/shop.dart';

class ShopController extends GetxController {
  var shopList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      final shopListData = await getAllShop();
      shopList.value = shopListData.shops;
    } catch (err) {
      Get.toNamed(RoutePath.loginPath);
      return Future.error(err);
    }
  }

  Future<AllShopsResponse> getAllShop() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    log(response.toString());
    response.raiseForStatus();
    return AllShopsResponse.fromJson(response.json());
  }
}
