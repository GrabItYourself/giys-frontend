import 'package:get/get.dart';
import 'package:giys_frontend/config/route.dart';
import 'package:requests/requests.dart';

import '../config/config.dart';
import '../models/shop.dart';

class MyShopController extends GetxController {
  final shop = Shop(id: 0, name: '').obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      final shopData = await getMyShop(1);
      shop.value = Shop(
          id: shopData.shop.id,
          name: shopData.shop.name,
          image: shopData.shop.image,
          description: shopData.shop.description,
          location: shopData.shop.location,
          contact: shopData.shop.contact);
    } catch (err) {
      Get.toNamed(RoutePath.homePath);
      return Future.error(err);
    }
  }

  // TODO get shop id from user credentials
  Future<ShopResponse> getMyShop(int id) async {
    final response = await Requests.get(
      '${Config.getServerUrl()}/api/v1/shops/$id',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    response.raiseForStatus();
    return ShopResponse.fromJson(response.json());
  }

  updateShop(Shop input) {
    shop(Shop(
        id: input.id,
        name: input.name,
        image: input.image,
        description: input.description,
        location: input.location,
        contact: input.contact));
  }
}
