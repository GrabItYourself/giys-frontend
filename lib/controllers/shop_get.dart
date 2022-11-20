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
      await getAllShop();
    } catch (err) {
      Get.toNamed(RoutePath.homePath);
      return Future.error(err);
    }
  }

  getAllShop() async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    final data = AllShopsResponse.fromJson(response.json());
    shopList.value = data.shops;
  }
}
